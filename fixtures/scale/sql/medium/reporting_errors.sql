-- Error-rate reporting for the settings precision guide.
CREATE VIEW error_rate_by_kind AS
SELECT kind, COUNT(*) AS occurrences
FROM errors
GROUP BY kind;

CREATE VIEW recent_conversions AS
SELECT c.id, fu.symbol AS from_symbol, tu.symbol AS to_symbol
FROM conversions c
JOIN units fu ON fu.id = c.from_unit_id
JOIN units tu ON tu.id = c.to_unit_id;
