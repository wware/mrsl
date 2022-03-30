# Tools for MRSL

Think about something like a bootable Linux CD or a Docker container
full of useful tools, and the scripting infrastructure to have them
all play together.

### Off the shelf

- Pyspread
- Jena/Fuseki
- Prolog interpreter
- Pandas/numpy/scipy/matplotlib
- R for number crunching
- Python for AI/ML
- Markdown editor, pandoc, etc
- d3, POV-Ray

### Custom

- Translator: CSV, Turtle, Dot, Prolog, JSON
- Library of scripting examples (Bash, Python, Scheme)
- Docs

## Discussion

This wants to provide examples of how MRSL could be useful and valuable to
somebody publishing a paper, i.e. make it worth their while to mark up their
paper with semantics that would allow a machine to read the paper's salient
content and do some kind of interesting processing on it. This might mean
validating the paper's conclusion, particularly if new data appears that
wasn't available at the time of publication.

> You could think of this as doing a set of unit tests against a hypothesis.
  You re-run the unit tests when conditions change, e.g. when new
  experimental data becomes available.

Using Turtle and RDF is one useful form of knowledge representation but
certainly not the only one. Numerical data can be collected in a lab and
can be manipulated with arithmetic and statistical methods. In computer
science, code is knowledge representation, and can be rendered as either
source code or as abstract syntax trees.

Take a few simple papers from PLoS or Pubmed. Find or create an ontology
for the  stuff in the papers. Rewrite the papers in Markdown. Show how to
render a pretty PDF, and how to extract RDF, and what you can do with the RDF.
Represent the contents of the paper, extrapolate further conclusions, plan
experiments, think about how the paper can interact with a related paper.
Each paper is a graph or semantic network, and you can find equivalencies
between the papers and notate them using the OWL operators.

Good sources of papers are PLOS.org and https://www.biomedcentral.com/ but alas
it turns out Pubmed is no longer a good source. One particular issue is that
any one of these papers is a complex beast, there are no simple ones, so
I would probably need to just work with some small fragment or section of
a paper. I would also hope to discover that most of the relevant ontology
had already been created by somebody else, and all I need to do is use theirs.

### Semantic spreadsheet

This idea post-dates the authoring tool idea, and may replace it entirely. The
idea here is that instead of writing a paper that some machine will
autonoumously read and reason about, you're developing a tool that tries to
extend a human user's reasoning capacity.

Take an open-source spreadsheet. Maybe use [Pyspread](https://pyspread.gitlab.io/)
since it targets the Python language, which already does a lot of the
number-cruncing for the AI/ML space, and because I'm already familiar with Python.

Add whatever functions and macros and stuff would make it reasonable to use
the spreadsheet to process semantic nets. When I say "process" what I mean
is you can assign RDF nodes to cells, and then you can assign probabilities
or truth values to particular nodes and propagate to see what happens. You're
doing Prolog-like operations in the semantic net, with all the ease-of-use
benefits you get with a spreadsheet.

So your spreadsheet can be a mix of normal spreadsheet stuff (whatever your
problem domain would normally include for numeric processing) and the
semantic stuff. You can apply reasoning and OWL and all that to the semantic
piece.

You can highlight nodes in different colors, do searches, maybe attach
comments to nodes, whatever.

You can import and export chunks of RDF along with the normal spreadsheet
things. You can import a subchunk into an existing spreadsheet. You can group
a bunch of cells and say, "This represents Bob's theory that X implies Y"
and treat that as a semantic subnet which you can then prod with tests.

* [Pyspread website](https://pyspread.gitlab.io/)
* [Paper on RDF123](https://ebiquity.umbc.edu/_file_directory_/papers/370.pdf)

It might make sense to write some macros for some spreadsheet. Avoid the
temptation to tinker with the source code for an established project, for a few
reasons.

* That code is very highly optimized and you'll break something.
* Users know that, and won't trust your work if you attempt it.
* You can't get support from the normal user community.

You want to be able to mark some portion of the spreadsheet contents, either
with the mouse, or by use of some kind of marker or highlight, and ideally
could be done programmatically. You want to be able to export the selected
portion and run it thru a translator that converts it from CSV to either Turtle
or Prolog. This is presumably done with some kind of spreadsheet macro, which
could then invoke the prolog interpreter or an RDF inference engine, do some
work, and convert the results of that work back to CSV.

The primary piece of work here is the translator between CSV and Turtle
and Prolog. Most spreadsheets probably let you define a macro that could
invoke the translator, or a shell script that invokes it. The shell script
could then run prolog or Jena on the result, do some reasoning, and you could
then translate the result back to CSV.

Generally it's a great idea not to dig around inside other peoples' code such
as Pyspread. If you can put some glue around it, like a translator, that is
much better.
