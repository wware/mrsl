# Machine-readable scientific literature

Around 2010, an idea occurred to me, and a month or two later, I saw it validated
experimentally. The idea was that machines could do more in science than simply
run lab equipment - they could participate in scientific reasoning, if information
were suitably represented that they could perform such reasoning.

The experimental validation of this was the
[Adam robot](https://singularityhub.com/2010/03/16/adam-the-robot-scientist-makes-its-first-discovery/)
built by Ross King, then at Aberystwyth University in Wales. Adam involved a computer
that ran a bunch of lab automation equipment, but additionally it performed
observations, formulated hypotheses based on those observations, designed experiments
to test those hypotheses, and performed those experiments. Adam enacted every step of
the scientific method, with minimal human oversight or assistance. That year, Adam
contributed genuinely new findings in the area of yeast genetics.

To enable machines as significant participants in scientific research, beyond the
role of lab automation, it is important to frame information in machine-readable terms,
that information including the observed data, the interpretation of that data, the
hypotheses that one might infer, the predictions resulting from those hypotheses, and
the design of experiments to test those predictions. So you want to find or invent
data structures that represent academic papers, hypotheses and theories, predictions
of the implications  of a hypothesis, and the design of experiments.

This repository attempts to develop some examples of practices that could enable a
machine-readable scientific literature. Some concerns to be addressed here include:

* What kinds of information or knowledge or data can be represented, and what sorts
  of representations might be appropriate for different kinds
* What sorts of reasoning a machine could apply to these different kinds of information
* How all of that could be brought into the practice of writing scientific papers
  without placing an unreasonable burden on an author

Some references

* https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3163424/
* https://www.annytab.com/first-order-logic-in-python/

## Semantic nets

Pandoc syntax highlighting recognizes the [Turtle](https://www.w3.org/TR/turtle/)
language, a textual representation of a semantic net as an RDF graph. Such representations
can be directly imported into [inference engines](https://en.wikipedia.org/wiki/Inference_engine).

```turtle
@base <http://example.org/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix rel: <http://www.perceive.net/schemas/relationship/> .

<#green-goblin>
    rel:enemyOf <#spiderman> ;
    a foaf:Person ;    # in the context of the Marvel universe
    foaf:name "Green Goblin" .

<#spiderman>
    rel:enemyOf <#green-goblin> ;
    a foaf:Person ;
    foaf:name "Spiderman", "??????????????-????????"@ru .
```

### Literate programming

Borrow useful ideas from Knuth's notion of "Literate Programming". A paper is intended
first for human readability and second for machine readability. Knuth envisioned two
processes applied to a source document.

* _Weaving_ the source document would provide a pretty and publishable
  human-readable document. It should produce a reasonable format like Markdown or
  LaTeX that can easily be further rendered into PDF or HTML.
* _Tangling_ the source document extracts source code or data files usable by a
  computer to work with the contents of the paper.

Recently I learned of [LMT](https://github.com/driusan/lmt), a golang program that can
perform the tangling process. Weaving could be done by [Pandoc](https://github.com/jgm/pandoc),
which applies syntax highlighting if it knows the language in which code or data
snippets are written.

### OWL

OWL lets you specify class hierarchies of objects in a semantic network,
and do some set-theoretic operations on them: subset, union, intersection,
stuff like that.

* https://www.w3.org/TR/owl-semantics/
* http://www.linkeddatatools.com/semantic-web-basics
* http://www.linkeddatatools.com/introducing-rdfs-owl
* https://en.wikipedia.org/wiki/Semantic_Web
* https://en.wikipedia.org/wiki/Web_Ontology_Language
* https://www.cs.man.ac.uk/~horrocks/ISWC2003/Tutorial/examples.pdf
* https://www.cs.man.ac.uk/~horrocks/ISWC2003/Tutorial/reasoning.pdf

### Languages for semantics

RDF/XML, Turtle, JSON-LD

* https://json-ld.org/
* https://json-ld.org/playground/

Why is there no YAML-LD?

https://lists.w3.org/Archives/Public/public-linked-json/2015Jan/0035.html

It looks like the biggest substatntial issue is this:
> One pitfall is that unfortunately you do need
> to quote all the keywords starting with '@'.

That said, people do like the idea, citing a few advantages over JSON-LD:

* Comments
* More concise and more readable

### Stuff about Prolog

Prolog is a logic programming language associated with artificial
intelligence and computational linguistics.

Prolog has its roots in first-order logic and is intended primarily
as a declarative programming language: the program logic is expressed
in terms of relations, represented as facts and rules. A computation
is initiated by running a query over these relations.

* [Prolog overview](http://www.cs.toronto.edu/~bonner/courses/2014f/csc324/slides/prolog1.pdf)
* [Prolog's Inference Engine](https://www.amzi.com/ExpertSystemsInProlog/02usingprolog.htm)
* [More Prolog inference engine](http://www.cs.sjsu.edu/~pearce/modules/lectures/prolog/engine.htm)
* [Computation in predicate logic](https://www.cs.rochester.edu/u/nelson/courses/csc_173/predlogic/computation.html)
* [Logic Programming course notes](https://athena.ecs.csus.edu/~mei/logicp/LogicP_StudyGuide.pdf)

## Where to go with all this stuff

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

This idea post-dates the authoring tool idea below, and may replace it
entirely. The idea here is that instead of writing a paper that some machine
will autonoumously read and reason about, you're developing a tool that tries
to extend a human user's reasoning capacity.

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

Start by forking Pyspread and figuring out a reasonable import process for
RDF/Turtle. Also think about export.

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
