// file      : hello/person.hxx
// copyright : not copyrighted - public domain

#pragma once

#include <string>
#include <cstddef> // std::size_t

#include <odb/core.hxx>

#pragma db object
class person {
    friend class odb::access;

    person() {}

#pragma db id auto
    unsigned long id_;

    std::string first_;
    std::string last_;
    unsigned short age_;

public:
    person(const std::string &first,
           const std::string &last,
           unsigned short age)
            : first_(first), last_(last), age_(age) {}

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
};

#pragma db view object(person)
struct person_stat {
#pragma db column("count(" + person::id_ + ")")
    std::size_t count;

#pragma db column("min(" + person::age_ + ")")
    unsigned short min_age;

#pragma db column("max(" + person::age_ + ")")
    unsigned short max_age;
};