SELECT EXISTS(
               SELECT
               FROM information_schema.tables
               WHERE table_schema = 'schema_name'
                 AND table_name = 'table_name');