# Validations example

This sample app shows how to validate user input on various app layers.

Validations included:

* default HTML5 validations (presence, etc.)
* form object taking care of basic input validations
* command handler taking care of business logic validations (uniqueness) without involving
  typical Rails model validations, but utilising the concept
  of [interim streams](https://blog.scooletz.com/2016/11/21/event-sourcing-and-interim-streams/)
  in a way [RailsEventStore](https://railseventstore.org/docs/v2/expected_version/#integer) supports this concept.

Last, but not least: 0 ActiveRecord models given.

## Setup

```shell
bin/setup

bin/dev
```
    