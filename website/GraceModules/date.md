---
title: The date Module
keywords: date, time, milliseconds, duration
sidebar: modules_sidebar
permalink: /modules/date/
toc: false
folder: Modules
author:
- 'Andrew P. Black'
---

## Dates and Times


The *date* module object can be imported using `import "date" as date`,
for any identifier `date` of your choice. 

`Date` objects represent dates and times. 
The object `date` responds to the following requests.

```
type Date = type {
    year -> Number
        // the year, e.g., 2016
    month -> Number
        // the month, e.g, for 1 for January, 4 for April
    date -> Number
        // the day of the month, from 1 to 31
    day -> Number
        // the day of the week, e.g. 1 for Sunday, 1 for Monday
    hour -> Number
        // the hour of the day, e.g. 16 for 4 pm
    minute -> Number
        // the minutes past the hour, e.g. 49 for 4:49 pm
    second -> Number
        // the seconds past the minute, e.g. 32 for 4:49:32 pm
    asString -> String
        // a string representation of this date and time
    asDateString -> String
        // a string representation of just the date part
    asTimeString -> String
        // a string representation of just the time part
    asIsoString -> String
        // a string representation that complies with ISO 8601
    == (other:Date) -> Boolean
        // is self == to other?
    + (other:Date) -> Date
        // the sum of self and other
    - (other:Date)
        // the difference betweem self and other
    * (factor:Number)
        // the product of self and factor
}

milliseconds(n) -> Date
    // answers the time n milliseconds after the epoch 

seconds(n) -> Date
    // answers the time n seconds after the epoch

minutes(n) -> Date
    // answers the time n minutes after the epoch

days(n) -> Date
    // answers the time n days after the epoch

weeks(n) -> Date
    // answers the time n weeks after the epoch

timeZoneOffset -> Date
    // answers the offset between local time and UTC, as a Date.

now -> Date
    // answers the current date and time

fromString(dateString:String) -> Date
    // interprets dateString as a Date, and returns it.
 
```
## Durations

Grace `Dates` represent both
absolute points on the timeline (such as 3rd February 1989) and durations (such
as 2 hours). Thus, a  duration of one week is represented by a date one
week after the epoch, and `date.now + date.days 2` is the date two days
from now.

