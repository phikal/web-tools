<!-- 1529542402 web -->

# Some Remarks on the (Idea of the) Modern Web

Since recently is has been popular to complain, make fun of or
occasionally even criticise the web as we know it, I decided to prepare
a comment from a conversation I had with a friend of mine regarding the
current state of the WWW.

It has been translated from German, I clarified some points and
reformatted it a bit to make it more easily readable, since it was
originally a _WhatsApp_ message (two messages to be precise).

My clarifying comments will be placed between square brackets, like
[this]. All links have been added while re-editing this text.

The statement I am reacting to is the following:

> Sites like Facebook undeniably have their issues. But isn't the
> fundamental concept seem practical, doesn't it? In the sense of having
> a website to communicate over.

The conversation was about the prospect of [new EU copyright
laws][eu-copyright] taking effect, mid 2018.

---

I am of the opinion that significant portions of the WWW are absolutely
harmful, technologically _and_ socially. [...] (_the quote from above_)
[...] Ok, I can set my sets out my criticism using this example:


## Technologically

> In the sense of having a website to communicate over.

I would point out that the _Function_ and the _Implementation_ have to
be conceptually held apart. Yes, modern communication is more efficient
and let's us have more dynamic conversations.

But from a purely technical perspective, there is no reason why this
should be done using websites (i.e. browsers using HTTP/HTML+CSS+JS to
inter operate [often using additional servers]).

The WWW has a historical burden and at the same time contemporary
requirements. The [original specification][rfc1945] couldn't have been
fit for the task, since it's impossible to "pre-standardize". New
developments take effect to compensate for the common "impotence", my
means of market-power (eg. [Internet Explorer during the 1990's and
early 2000's][ie-history]).

All of this leads to increasingly complex "standards", which in turn are
caught in a conflict between these and _newer_ "unofficial" (but
de-facto _real_) developments.

This is one of the reasons why web engines have and are becoming more
and more complex [see [Wikipedia article][web-engine] on the
topic]. Additionally there is also the fact that people are denying that
fact that HTML made for text [_Hyper_ **Text** _Markup Language_],
instead browsers have become operating systems in their own right [think
of [SKID #1367][xkcd1367].], with Firefox for example having to have to
use custom (plural!) [memory allocators][firefox-malloc], or the HTML
standard having to accept ["malformed" code][head-tag], in order for
their browsers to be usable [a common example is the non-closed
`<p>`-tag].

All these [in my opinion] negative developments of the WWW (albeit, not
necessarily the _Internet_ as a whole), should have to
change. Tendencies like these, to abuse the WWW, are not only
unpractical, but require a lot of work and time. For reasons like these
I hope that the [the aforementioned EU Copyright] Law will at least
initiate a conversation. And I say that, while not being a great friend
of copyright in general.

# Socially

> But isn't the fundamental concept seem practical, doesn't it?

In this case I demand something else: _Intention_ and _Reality_ cannot
be separated from one-another. What we see with "projects" like
Facebook, Twitter, etc. cannot be explained away be demonising the evil
natures Mark [Zuckerberg] or Jack [Dorsey]. There is always a not
negligible mechanical component to the developments of such major
players [painted over by the characters of the people involved and in
charge]. 

To survive as a "Social Media Service" the size of Facebook, certain
decisions _have_ to be made to survive [and especially grow]. It's also
worth remembering that most Social Networks aren't even that profitable
[even major networks, [like Twitter][twitter-profit]].

The work that has to be invested to maintain, and this is related to the
technical points from above, infrastructures that gather, analyse and
use such amounts of data [Facebook for example [has data warehouses
with 300 petabytes of data, and generates 4 new petabytes a
day][facebook-stat]] is most undeniably non-trivial. 

To put it this way: _The fact that Facebook collects data, the way it
does, the way they do it, cannot be detached from the structure of the
network (centralized storing and distribution of data)._ 

I would also like to point out, that regarding this issue, I am not as
thoroughly optimistic as some are when it comes to decentralisation [of
internet services]. The reason being that historically most networks
have suffered under an inability to sustain large influxes of new users
while maintaining conventions [think of [Eternal September][et-sep]] or
the will to stay decentralized (think of the relation of Gmx, Hotmail,
Gmail to Email as a whole).

My second point is that due to the perpetual technical advances, these
[eg. browsers, TPC, personal computer, ...] have been becoming ever
faster. I claim that this in turn influences human interactions.

It can be seen, in a banal way, that the structure of a network
critically influences it's inner workings [like the layout of a city
influences it's inhabitants daily lifes].

WhatsApp, which uses private groups, direct chats and phone numbers has
a different mode of usage than Facebook with their timelines,
[user-profiles,] non-linear streams and public groups, which in turn
operates differently that Twitter where everything is public by default,
and messages [as in the unit of communication] are simpler.

My point is: As the speed [originally "tackrate", _cycle speed_] of
Computers [and Networks] increase, so does that of our societies.  The
effect of this is that ability to articulate oneself is increasingly
diminishing. With everything happening too quickly [and this isn't
necessarily even a purely recent development], people often tend to pass
judgment quickly and without enough thought [or uncritically accept
other narratives]. Thus the ability of social networks to enable
communication, quickly and painlessly, ends up in _misarticulation_
rather than being a progressive force [as I assume that many early
Interet-Idealist might have hoped for]. 

I argue that this ends up pervades all of society, from personal
relationships between close friends to the political sphere.

One might at first say that this has more to do with "Social Media",
than the _generic_ WWW. But the fact that most sites end up in the
proximity of major networks and often enough don't just adapt but get
absorbed into these [since they are interested in getting media
attention, and that's just where most people are], is in my eyes an
argument that all of this is tied together. [Especially when concidering
that for many people ["Facebook" isn't on the
"Internet"][facebook-usage]].

[rfc1945]: https://tools.ietf.org/html/rfc1945
[ie-history]: https://en.wikipedia.org/wiki/History_of_Internet_Explorer
[web-engine]: https://en.wikipedia.org/wiki/Browser_engine#Notable_engines
[head-tag]: https://www.w3.org/TR/html401/struct/global.html#h-7.4.1
[xkcd1367]: https://xkcd.com/1367/
[firefox-malloc]: https://developer.mozilla.org/en-US/docs/Mozilla/Choosing_the_right_memory_allocator
[eu-copyright]: https://en.wikipedia.org/wiki/Directive_on_Copyright_in_the_Digital_Single_Market
[twitter-profit]: https://www.recode.net/2018/2/8/16989834/twitter-q4-2018-earnings-revenue-jack-dorsey
[facebook-stat]: https://research.fb.com/facebook-s-top-open-data-problems/
[et-sep]: https://en.wikipedia.org/wiki/Eternal_September
[facebook-usage]: https://qz.com/333313/milliions-of-facebook-users-have-no-idea-theyre-using-the-internet/
