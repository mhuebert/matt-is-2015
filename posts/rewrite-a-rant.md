# Rewrite a Rant

<style>
del {
  color: #777;
}
blockquote {
  font-style: normal;
}
</style>

Linus Torvalds, principal force behind the Linux kernel:

> <del>Where do I start a petition to raise the IQ and kernel knowledge of people?</del> Guys, go read drivers/char/random.c.<del> Then, learn about cryptography. Finally, come back here and admit to the world that you were wrong. Short answer: we actually know what we are doing. You don't. Long answer:</del> we use rdrand as _one_ of many inputs into the random pool, and we use it as a way to \_improve_ that random pool. So even if rdrand were to be back-doored by the NSA, our use of rdrand actually improves the quality of the random numbers you get from /dev/random. <del>Really short answer: you're ignorant.</del> ([link](http://www.theregister.co.uk/2013/09/10/torvalds_on_rrrand_nsa_gchq))

and

> Ok. I still really despise <del >the absolute incredible sh*t that is</del>
non-discoverable buses<del >, and I hope that ARM SoC hardware designers all
die in some incredibly painful accident</del>. DT only does so much.</p>
<p><del >So if you see any, send them my love, and possibly puncture the
brake-lines on their car and put a little surprise in their coffee,
ok?</del> ([link](http://www.theregister.co.uk/2013/09/11/torvalds_suggests_poison_and_sabotage_for_arm_soc_designers/))