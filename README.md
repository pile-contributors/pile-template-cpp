C++ pile template
=================

This is a simple template to use when generating new
piles for a C++ class.

*tempile*, *TemPile* and *TEMPILE* are place-holders both in
the name of the files and directories and in also in
the content of files.

Templates
=========

The process of creating a pile from a template goes like
this:

    - the template directory must contain a *pile* directory
	and a *pile-helpers* directory (literally the world **pile**, this
	is not a place-holder);
	- a directory is created for the pile and one for the helpers;
	- everything is copied recursively, with 
	*tempile*, *TemPile* and *TEMPILE* replaced with 
	pile's name in similar case both in names and in content;
	- a repository is initialized in each of the two directories 
	(pile and helpers); a commit is created and, well..., committed;
	- the pile is added as a sub-module inside the helpers directory
	