# Beany Backend

* All FS operations go here
* All Git Operations go here
* Anything even remotely computationally expensive goes here

-----
* We cannot use Protobufs as they aren't supported on the web
* Lets use basic JSON for server-client communication

* This exposes a BeanyClient library
  - Abstract class
  - Two implementations - BeanyClientHttp and BeanyClientIsolate
