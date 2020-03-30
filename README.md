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
    foaf:name "Spiderman", "Человек-паук"@ru .
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


## Where to go with all this stuff

This wants to provide examples of how MTSL could be useful and valuable to
somebody publishing a paper, i.e. make it worth their while to mark up their
paper with semantics that would allow a machine to read the paper's salient
content and do some kind of interesting processing on it. This might mean
validating the paper's conclusion, particularly if new data appears that
wasn't available at the time of publication.

Using Turtle and RDF is one useful form of knowledge representation but
certainly not the only one. Numerical data can be collected in a lab and
can be manipulated with arithmetic and statistical methods. In computer
science, code is knowledge representation, and can be rendered as either
source code or as abstract syntax trees.

Take a few simple papers from Pubmed. Find or create an ontology for the
stuff in the papers. Rewrite the papers in Markdown. Show how to render
a pretty PDF, and how to extract RDF, and what you can do with the RDF:
represent the contents of the paper, extrapolate further conclusions, plan
experiments, think about how the paper can interact with a related paper.
Each paper is a graph or semantic network, and you can find equivalencies
between the papers and notate them using the OWL operators.

Good sources of papers are PLOS.org and https://www.biomedcentral.com/ but alas
it turns out Pubmed is no longer a good source. One particular issue is that
any one of these papers is a complex beast, there are no simple ones, so
I would probably need to just work with some small fragment or section of
a paper. I would also hope to discover that most of the relevant ontology
had already been created by somebody else, and all I need to do is use theirs.

### Authoring tool

Try to describe and hopefully prototype an authoring tool for MTSL papers
to ease the burden of creating them. No researcher will bother with any
of this stuff if it adds any appreciable effort to authoring a paper. Like
an IDE used in programming, the authoring tool should offer helpful feedback
during the authoring process.

The authoring tool is essentially an IDE for writing academic papers with all
these features. I should build the tool that I want for myself.

Given that Apache Jena is a big part, and Apache Jena is available in a Docker
container, it probably makes sense to architect it as a collection of containers
that are orchestrated using docker-compose. So design it that way, and think
about persistence and the need for mounted volumes. Also think about git
integration.

Let's look at the components involved.

#### Apache Jena and Fuseki

[Existing well-maintained docker containers](https://github.com/stain/jena-docker)

These can import and export ontologies and semantic nets in a variety of
formats (RDF/XML, N3/Turtle, JSON-LD) and with a little more work I can run
Graphviz and produce Dot files, JPEG, or PNG.

Jena should make ontologies easy to search and use, and provide easy integration
with DBpedia, OWL, and other Linked Data resources.

Fuseki is a web server that handles SPARQL queries.

#### Graphviz, ImageMagick

#### Remarkable

https://github.com/jamiemcg/Remarkable for Markdown editing

#### LMT

https://github.com/driusan/lmt

lmt is a tool for extracting text from the code blocks in markdown files. It
allows programmers to write in a [literate programming](https://en.wikipedia.org/wiki/Literate_programming)
style using Markdown as the source language.

#### Pandoc

### Reasoning tools

So you get your paper written, and it's full of semantic markup, and now
both humans and machines can understand its contents. What next?

The humans will read the paper and think about where it fits in the
larger scientific literature, what are its implications, how it relates
to other current work, etc. You want the machines to do more or less the
same thing.

At a minimum you want to do something involving an inference engine.
This whole area warrants more thought.

### An example "paper"

One purpose of the present work is to write at least a first draft of a
"paper" that employs a mix of ordinary text and semantic markup of some
kind, and ideally, to demonstrate how this markup might be used to
extract machine-comprehensible content from the paper and perform
some kind of deduction or reasoning on it.

> ### What is the current status, and what are some advantages and disadvantages, of the leading Ebola virus vaccines?
> Thirteen EBOV vaccine candidates have entered human clinical trials with 5 progressing to
post-Phase I clinical trials [8]. Strengths and weaknesses for each of the 5 platforms are sum-
marized in Table 1. The most advanced vaccines in the United States and Europe include Ervebo (rVSV-EBOV), Zabdeno/Mvabea (Ad26-ZEBOV/MVA-BN-Filo), and cAd3-EBOZ
(Fig 1). All 3 platforms use a viral vector, or a modified version of a harmless surrogate virus,
to provoke an immune response. Key benefits of virus-vectored vaccines are their ability to
deliver antigen specifically to target cells and to induce robust, long-lived immunity.
> Ervebo, Zabdeno/Mvabea, and cAd3-EBOZ all express EBOV glycoprotein (GP) antigen to stimulate
an immune response. GP is the sole surface protein of the EBOV virion and mediates attachment, fusion, and entry of target cells; thus, this protein serves as an attractive immunogen as
it is readily recognized by the immune system and is the main target of the neutralizing anti-
body response [9]. Some general disadvantages of virus vaccine vectors include manufacturing
obstacles, cold chain requirements, and difficulty in adapting to new virus variants.

Let's try to render Table 1 in Turtle.
