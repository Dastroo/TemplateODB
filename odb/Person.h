//
// Created by dawid on 24.04.22.
//

#pragma once

#include <string>
#include <odb/core.hxx>     // (1)
#include <utility>

#pragma db object
class Person {
public:
    Person(std::string first,
           std::string last,
           unsigned short age)
            : first_(std::move(first)), last_(std::move(last)), age_(age) {
    }

    const std::string &
    first() const {
        return first_;
    }

    const std::string &
    last() const {
        return last_;
    }

    unsigned short
    age() const {
        return age_;
    }

    void
    age(unsigned short age) {
        age_ = age;
    }

private:
    friend class odb::access;

    Person()=default;

#pragma db id auto
    unsigned long id_;

    std::string first_;
    std::string last_;
    unsigned short age_;
};