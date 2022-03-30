# Authoring tool

Try to describe and hopefully prototype an authoring tool for MRSL papers
to ease the burden of creating them. No researcher will bother with any
of this stuff if it adds any appreciable effort to authoring a paper. Like
an IDE used in programming, the authoring tool should offer helpful feedback
during the authoring process. The authoring tool is essentially an IDE for
writing academic papers with all these features. I should build the tool
that I want for myself.

### Floating cloud of nodes

The stuff you put in your academic paper becomes part of the semantic net.
Maybe the net is published in a separate file, and you use additional RDF pieces
to represent comments or annotations or anchors for the paper to reference.

Think about how to visualize a semantic net as a graph, and what that looks
like at different zoom levels, and how to keep it useful and purposeful. And
there can be links from the paper into different points in the graph. And the
graph can reshape itself, so that some parts get closer or farther away as your
interests and priorities change.

* https://observablehq.com/@d3/mobile-patent-suits

When you're viewing a net in this way, you can select a node and manually set
its probability or its truth value, or you can highlight it so you can keep an
eye on it. You can do bulk highlighting operations using something like a
SQL/SPARQL query. And you can propagate changes across the net to see how
things respond as you tinker with applying external stimuli.

That's all lovely but potentially very hard to do. You invest in a lot of
pretty work on graphics and it's not clear that it buys you a lot of real value.
Thinking about that led me to the spreadsheet idea above.

## Components

Given that Apache Jena is a big part, and Apache Jena is available in a Docker
container, it probably makes sense to architect it as a collection of containers
that are orchestrated using docker-compose. So design it that way, and think
about persistence and the need for mounted volumes. Also think about git
integration.

Let's look at the components involved.

### Apache Jena and Fuseki

[Existing well-maintained docker containers](https://github.com/stain/jena-docker)

These can import and export ontologies and semantic nets in a variety of
formats (RDF/XML, N3/Turtle, JSON-LD) and with a little more work I can run
Graphviz and produce Dot files, JPEG, or PNG.

Jena should make ontologies easy to search and use, and provide easy integration
with DBpedia, OWL, and other Linked Data resources.

Fuseki is a web server that handles SPARQL queries.

### Graphviz, ImageMagick

### Remarkable

https://github.com/jamiemcg/Remarkable for Markdown editing

### noweb.py

noweb.py is a tool for extracting text from the code blocks in markdown files. It
allows you to write code in a [literate programming](https://en.wikipedia.org/wiki/Literate_programming)
style. I've tweaked it to accept Markdown as an input language.

### Pandoc

## Reasoning tools

So you get your paper written, and it's full of semantic markup, and now
both humans and machines can understand its contents. What next?

The humans will read the paper and think about where it fits in the
larger scientific literature, what are its implications, how it relates
to other current work, etc. You want the machines to do more or less the
same thing.

At a minimum you want to do something involving an inference engine.
This whole area warrants more thought.

You can make computational models of all kinds of things, why not the
elements of scientific reasoning? Why do those have to be semantic nets?
Why not some other thing?

* Generate hypothesis
* Generate predictions
* Design experiments to test predictions
* Run experiments and observe results
* Update state of knowledge
* Repeat cycle
