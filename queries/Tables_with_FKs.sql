-- Query 1: Count of foreign keys per table
SELECT n.nspname AS schema,
       t.relname AS table, 
       COUNT(c.conname) AS fk_count
FROM pg_class t
JOIN pg_namespace n ON n.oid = t.relnamespace
JOIN pg_constraint c ON (c.conrelid = t.oid AND c.contype = 'f')
WHERE t.relkind = 'r'
  AND t.relname NOT LIKE 'pg_%'
  AND t.relname NOT LIKE 'sql_%'
GROUP BY n.nspname, t.relname
ORDER BY fk_count, n.nspname, t.relname;

-- Query 2: List all foreign keys
SELECT n.nspname AS schema, 
       t.relname AS table, 
       c.conname AS fk_name
FROM pg_class t
JOIN pg_namespace n ON n.oid = t.relnamespace
JOIN pg_constraint c ON (c.conrelid = t.oid AND c.contype = 'f')
WHERE t.relkind = 'r'
  AND t.relname NOT LIKE 'pg\_%'
  AND t.relname NOT LIKE 'sql\_%'
ORDER BY n.nspname, t.relname, c.conname;
