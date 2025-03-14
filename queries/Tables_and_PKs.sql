SELECT n.nspname AS schema_name,
       t.relname AS table_name, 
       c.conname AS pk_name
FROM pg_class t
JOIN pg_constraint c ON (c.conrelid = t.oid AND c.contype = 'p')
JOIN pg_namespace n ON (n.oid = t.relnamespace)
WHERE t.relkind = 'r'
  AND t.relname NOT LIKE 'pg\_%'
  AND t.relname NOT LIKE 'sql\_%'
ORDER BY n.nspname, t.relname, c.conname;
