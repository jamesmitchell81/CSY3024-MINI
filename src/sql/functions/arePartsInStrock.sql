DROP FUNCTION IF EXISTS arePartsInStrock;

DELIMITER $$

CREATE FUNCTION arePartsInStrock(partID INT, quantity INT) RETURNS BOOLEAN
BEGIN


RETURN EXISTS (
	SELECT * 
    FROM PartsStockView
    WHERE idPartType = partID
    AND InStock >= quantity
);


END $$

DELIMITER ;