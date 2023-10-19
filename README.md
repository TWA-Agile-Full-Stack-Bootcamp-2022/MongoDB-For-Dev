# MongoDB for Dev

## 1. Deploy MongoDB in local

### Option 1: Install MongoDB on the Host

See https://www.mongodb.com/docs/manual/administration/install-community/

### Option 2: Install MongoDB in the Docker Container

Install docker first, then execute

```sh
./auto/up.sh
```

## 2. Add `MongoDB.Driver` and Remove `Entity Framework Core` framework from your project

> Mongo doesn't need an ORM(Object Relational Mapper) framework. The Mongo driver takes typed C# objects and does all the serialization for you. So you'd have a IMongoCollection<SomeType> and then you can insert objects of that type into it, when you query them out again they;re returned as C# objects. So Mongo doesn't need an Object Relational Mapper because it doesn't store the data in a relational database. It serializes objects to bson (binary json) and stores then as a single document. So all you need is the Driver and you can put your objects in there and query them out again.
> The MongoDB does have a Provider for Entity Framework Core but it's still in public preview, so we don't recommend using it.

- (**Optional**)Remove the provider for `Entity Framework Core` framework

```sh
dotnet remove ${PROJECT_FOLDER} package Pomelo.EntityFrameworkCore.MySql
dotnet remove ${PROJECT_FOLDER} package Pomelo.EntityFrameworkCore.MySql.Design
```

The `PROJECT_FOLDER` could be like `TWA-Agile-Full-Stack-Bootcamp/MiniBlog/MiniBlog`

- Add `MongoDB.Driver` to your project

```sh
dotnet add ${PROJECT_FOLDER} package MongoDB.Driver
```

## 3. MongoDB Schema Design

See more information here: [MongoDB Schema Design Best Practices](https://www.mongodb.com/developer/products/mongodb/mongodb-schema-design-best-practices/)

## `One-to-One` - Prefer key value pairs within the document

Example: user-to-name

> Let's say one user can only have one name.

```json
{
    "_id": "ObjectId('AAA')",
    "name": "Joe Karlsson",
    "company": "MongoDB",
    "twitter": "@JoeKarlsson1",
    "twitch": "joe_karlsson",
    "tiktok": "joekarlsson",
    "website": "joekarlsson.com"
}
```

## `One-to-Few` - Prefer embedding

Example: user-to-addresses

> Let's say we might need to store several addresses associated with a given user.

```json
{
    "_id": "ObjectId('AAA')",
    "name": "Joe Karlsson",
    "company": "MongoDB",
    "twitter": "@JoeKarlsson1",
    "twitch": "joe_karlsson",
    "tiktok": "joekarlsson",
    "website": "joekarlsson.com",
    "addresses": [
        { "street": "123 Sesame St", "city": "Anytown", "cc": "USA" },
        { "street": "123 Avenue Q",  "city": "New York", "cc": "USA" }
    ]
}
```

## `One-to-Many` - Prefer referencing

Example: product-to-part.

> Let's say we might have a Products collection with data about each product in our e-commerce store, and in order to keep that part data linked, we can keep an array of Object IDs that link to a document that has information about the part.

product:
```json
{
    "name": "left-handed smoke shifter",
    "manufacturer": "Acme Corp",
    "catalog_number": "1234",
    "parts": ["ObjectID('AAAA')", "ObjectID('BBBB')", "ObjectID('CCCC')"]
}
```

part:
```json
{
    "_id" : "ObjectID('AAAA')",
    "partno" : "123-aff-456",
    "name" : "#4 grommet",
    "qty": "94",
    "cost": "0.94",
    "price":" 3.99"
}
```

## `One-to-Squillions` - Prefer referencing

Example: host-to-log.

> Let's say you have been asked to create a server logging application. Each server could potentially save a massive amount of data

host:
```json
{
    "_id": ObjectID("AAAB"),
    "name": "goofy.example.com",
    "ipaddr": "127.66.66.66"
}
```

log:
```json
{
    "time": ISODate("2014-03-28T09:42:41.382Z"),
    "message": "cpu is on fire!",
    "host": ObjectID("AAAB")
}
```

## `Many-to-Many` - Prefer referencing

Example: user-to-task.

> Let's say a user may have many tasks and a task may have many users assigned to it.

user:
```json
{
    "_id": ObjectID("AAF1"),
    "name": "Kate Monster",
    "tasks": [ObjectID("ADF9"), ObjectID("AE02"), ObjectID("AE73")]
}
```
task:

```json
{
    "_id": ObjectID("ADF9"),
    "description": "Write blog post about MongoDB schema design",
    "due_date": ISODate("2014-04-01"),
    "owners": [ObjectID("AAF1"), ObjectID("BB3G")]
}
```
