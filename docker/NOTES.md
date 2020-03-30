# Random notes

Random useful little docker commands

```
docker image ls
docker ps -a
docker system prune
docker image rm mtsl
```

How to spin up a container, run a command in a particular directory, and make it go away

```
docker run --rm -it -w /aima-python mtsl-aima python3 /usr/local/bin/py.test

                       ^            ^         ^
                       |            |         |
                       |            |         here is the command we are running
                       |            here is the docker image to run this command
                       here is the directory to run the command in
```

## More significant stuff

Let's take specific computations, write them as code, and then do a literate
programming style hack to turn them into fundamentally human documents where the
code is visible but secondary.

It's very easy to do that with numerical stuff and that will probably not be too
novel. Plenty of things like that have been done in the past.

What gets interesting is when the computation is more symbolic and logical, more
like the reasoning process that might follow the logic of a published paper. And
then make the writing around that be the paper you're following. But write the
machine part first because while this stuff is in its infancy, that's the part that
takes more work to get it right.
