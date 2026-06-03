CREATE FUNCTION build(w widget_type, n integer) RETURNS widget_type AS $$ SELECT w; $$ LANGUAGE sql;

CREATE FUNCTION reorder(n integer, w widget_type) RETURNS widget_type AS $$ SELECT w; $$ LANGUAGE sql;
