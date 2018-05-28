# MGLogger
Logger for swift. You can log by level, by categories, by both, by using different level for different categories

------

### PROVIDE THE CONDITION FOR PRINT A LOG

```MGL.showLogWithMinimumLevel(_ level: LogLevel)```

This will provide to the logger the minimum level of log. No matter the category of the message.
So if you provide .noLog, no message will be printed in console.
If you provide .info, message with level lower or equal will be printed (in this case .info, .warning, .error)
If you provide .error, only .error message will be printed (because is the lower level)


```MGL.showLogWithCategoryIn(_ categories: [LogCategory])``` 

This will tell to the logger the categories of log. No matter the level of the message.
So if you provide [], no log will be printed.
If you provide [.notSpecified] only message with the .notSpecified category will be printed
If you provide [.notSpecified, .custom, .UI] only message with the .notSpecified OR .custom OR .UI category will be printed


```MGL.showLogWithMinimumLevel(_ level: LogLevel, inCategories categories: [LogCategory]) ```

This will use the level and the categories togheter for choose what to print or not.
So providing .info and [.notSpecified] will produce that only message with .notSpecified category and a log level lower or equal level to .info will be printed
If you provide .info and [.notSpecified, .UI] will produce that only message with .notSpecified OR .UI category, and a log level lower or equal level to .info will be printed


```MGL.showLogWithSpecificLevelForCategories(_ array: [LogLevel:[LogCategory]])```

This is very specific. You can provide a level for every category. In poor words, is LogWithMinimumLevel but you can apply different pattern of loggin level to different categories
If you provide 
```
[.info: [.notSpecified, .UI],
.error: [.connection],
.verbose: [.timing]]
```
will produce:

- message with .notSpecified OR .UI category, and a log level lower or equal level to .info will be printed
- message with .connection category, and a log level lower or equal level to .error will be printed
- message with .timing category, and a log level lower or equal level to .verbose will be printed

------

### LOG A MESSAGE


```MGL.log(_ text: String, level: LogLevel? = defaultLevel, category: LogCategory? = defaultCategory) ```

This will just ask to the logger to print in console the message. If you don't put level and/or category, the message gain the default level and/or category.
The logger then, when the code will be executed, check if the conditions that you have provided before permit to print the log.


```MGL.log(_ text: String, level: LogLevel?, categories: [LogCategory]?) ```

This will just ask to the logger to print in console the message giving him different categories. If you set to nil the level and/or category, the message gain the default level and/or category.
The logger then, when the code will be executed, check if the conditions that you have provided before permit to print the log.

------

### STYLE AND DEFAULT VALUES


```MGL.setLogStyle(prefix: String, showLevel: Bool, showCategories: Bool)```

Set the log style, the prefix of the string and if it must show the level and the categories before the text to log


```MGL.setLogDefaultLevel(_ level: LogLevel)```

Set default log level value. It means that if you log without provide a level, the log will have the default level
eg: 
MGL.setLogDefaultLevel(.verbose)
MGL.log("test log") it will be equal to MGL.log("test log", level: .verbose)


```MGL.setLogDefaultCategory(_ category: LogCategory)```

Set default log category value. It means that if you log without provide a category, the log will have the default category
eg: 
MGL.setLogDefaultCategory(.notSpecified)
MGL.log("test log") it will be equal to MGL.log("test log", category: .notSpecified)
