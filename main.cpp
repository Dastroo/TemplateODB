#include <iostream>

#include <memory>   // std::auto_ptr

#include <odb/database.hxx>
#include <odb/transaction.hxx>

#include <odb/pgsql/database.hxx>
#include <fstream>

#include "odb/Person.h"
#include "odb/Person-odb.hxx"

using namespace odb::core;

void create_db(const std::unique_ptr<database> &db, const std::string &sql_path) {
    std::ifstream ifs(sql_path);
    std::string content((std::istreambuf_iterator<char>(ifs)),
                        (std::istreambuf_iterator<char>()));

    transaction t(db->begin());
    db->execute(content);
    t.commit();
}


int main(int argc, char *argv[]) {
    try {
        std::unique_ptr<database> db(new odb::pgsql::database(argc, argv));

        create_db(db, "../odb/Person.sql");

        unsigned long john_id, jane_id, joe_id;

        // Create a few persistent Person objects.
        {
            Person john("John", "Doe", 33);
            Person jane("Jane", "Doe", 32);
            Person joe("Joe", "Dirt", 30);

            transaction t(db->begin());

            // Make objects persistent and save their ids for later use.
            john_id = db->persist(john);
            jane_id = db->persist(jane);
            joe_id = db->persist(joe);

            std::cout << john_id << jane_id << joe_id << std::endl;

            t.commit();
        }
    }
    catch (const odb::exception &e) {
        std::cerr << e.what() << std::endl;
        return 1;
    }

    return 0;
}
