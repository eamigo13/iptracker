# Instructions
## The Challenge

Imagine your team has developed a web service, and you want to keep track of the IP addresses that are making the most requests to your service each day. Your job is to write a program that (1) tracks these IP addresses in memory, and (2) returns the top100 most common IP addresses.

In the language of your choice, please implement these functions:

`request_handled(ip_address)`

This function accepts a string containing an IP address like “145.87.2.109”. This function will be called by the web service every time it handles a request. The calling code is outside the scope of this project. Since it is being called very often, this function needs to have a fast runtime.

`top100()`

This function should return the top 100 IP addresses by request count, with the highest traffic IP address first. This function also needs to have a fast runtime. Imagine it needs to provide a quick response to display on a dashboard, even with 10s of millions of IP addresses.

`clear()`
Called at the start of each day to forget about all IP addresses and tallies.

## Write Up
Please provide a written description of your approach that explains:

- What would you do differently if you had more time?

- What is the runtime complexity of each function?

- How does your code work?

- What other approaches did you decide not to pursue?

- How would you test this?


## Notes

- We won’t be compiling or running your code, so the syntax doesn’t have to be perfect.

- Any language is fine. Don’t worry about using a language that has a good or bad reputation for performance.

- Assume this web service gets tens of millions of requests each day.

- If your language requires it, you are welcome to implement these functions as class methods (e.g., Java) or as functions in a module (e.g., Python).

- Feel free to use idiomatic style for your language of choice, such as camelCase or snake_case, including changing the names of the functions and parameters above.


## Assessment

Your code will be assessed for:

- Coding style: Is the code easy to read? Are the names clear?

- Data structure choice: Did you choose data structures that are conducive to solving the problem?

- Speed: Does the code run optimally fast with tens of millions of unique IP addresses?

- Documentation: Is the writing clear?