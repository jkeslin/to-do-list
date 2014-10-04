Command Line To Do List
==========


## Purpose

To demonstrate a to do list that is written in Ruby in the MVC (Model View Controller) style and uses the Ruby CSV library to read and update a csv (comma seperated values) file. 


## Getting Started

clone the repo by typing

```
git clone https://github.com/jkeslin/to-do-list.git
```

open the todo.rb and todo.csv file in Sublime text

Change your directory to the to-do-list repo and run the program by typing:

```
ruby todo.rb
```

Running the program without any text following 'ruby todo.rb' should print the following list of potential commands:

```
Command Options: 'display' 'add' 'delete' 'completed'
```

to display the list, type the follwing in the command line: 
```
ruby todo.rb display
```

to add a to do, write 'add' followed by the text of the item you would like to add to the list. for example
```
ruby todo.rb add get bread from grocery store
```

to delete, write the item number that you would like to delete:
```
ruby todo.rb delete 3
```

to mark an item as completed, write the item number of the item that you completed:
```
ruby todo.rb completed 2
```

Check out the resoureces below!

## Resources

[Ruby CSV Class](http://ruby-doc.org/stdlib-1.9.3/libdoc/csv/rdoc/CSV.html)  
[Great Guide to the Ruby CSV Library](http://www.sitepoint.com/guide-ruby-csv-library-part/)  
[Great Guide to ARGV](http://www.sitepoint.com/ruby-command-line-interface-gems/)
