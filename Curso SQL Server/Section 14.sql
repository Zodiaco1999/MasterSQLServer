CREATE PROCEDURE SP_ActualizarProductosConDescuento(
    @mayorA100 DECIMAL(18,2), 
	@entre50y100 DECIMAL(18,2), 
	@menorA100 DECIMAL(18,2)
)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

	    DECLARE @ProductId INT, @CurrentPrice DECIMAL(10,2), @Stock INT, @NewPrice DECIMAL(10,2)

		DECLARE ProductCursor CURSOR FOR
		    SELECT ProductID, Price, Stock FROM Products;
        
		UPDATE Products
        SET Price = 
        CASE 
            WHEN Stock > 100 THEN Price * (1 - (@mayorA100 / 100))
            WHEN Stock BETWEEN 50 AND 100 THEN Price * (1 - (@entre50y100 / 100))
            ELSE  Price * (1 - (@menorA100 / 100))
        END;

		OPEN ProductCursor;

		FETCH NEXT FROM ProductCursor INTO @ProductId, @CurrentPrice, @Stock;

		WHILE @@FETCH_STATUS = 0
		BEGIN
		    IF @Stock > 100
			    SET @NewPrice = @CurrentPrice * (1 - (@mayorA100 / 100))
		    ELSE IF @Stock BETWEEN 50 AND 100
			    SET @NewPrice = @CurrentPrice * (1 - (@entre50y100 / 100))
			ELSE
			    SET @NewPrice = @CurrentPrice * (1 - (@menorA100 / 100))

			UPDATE Products SET Price = @NewPrice WHERE ProductID = @ProductId
			FETCH NEXT FROM ProductCursor INTO @ProductId, @CurrentPrice, @Stock;

		END

		CLOSE ProductCursor;
		DEALLOCATE ProductCursor;
		
	END TRY
	    
	BEGIN CATCH
	    PRINT 'Ocurrio un error en la actualización'
		SELECT ERROR_MESSAGE(), ERROR_NUMBER()

		IF CURSOR_STATUS('global', 'ProductCursor') >= 0
		BEGIN		
		    CLOSE ProductCursor;
		    DEALLOCATE ProductCursor;
		END

	END CATCH
END
GO