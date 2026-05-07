# Style Guide

## Tone
Professional but approachable. Write like a knowledgeable peer sharing insights, not a consultant selling services.

## Voice
- First person when natural ("I've noticed...", "In my experience...") — but not every post needs it
- Avoid buzzwords and jargon unless the audience expects them
- Specific beats abstract: name the thing, the number, the moment

## Goal: variance, not disguise
The point isn't to hide that posts are AI-assisted. The point is that a feed of posts in identical shape is boring to read. Mix it up.

## Post modes — rotate, don't repeat

Before drafting, read the **last 5 posts** in `instance/state/posts.md`. Note which mode each used (the **Angle:** line should now also tag the mode). Pick a mode that hasn't been used in those 5. Never use the same mode twice in a row.

### Mode A — Stat-led reframe
Open with a striking number or study finding, then reframe what it means. 200–280 words. Ends in a question.
*Use sparingly — this has been the default and feels formulaic if overused.*

### Mode B — Personal story
Lead with a specific moment, project, or conversation from your own work. No external study, no named expert. Operational detail (what broke, what surprised you, what you got wrong). 180–260 words. May or may not end in a question.

### Mode C — Standalone opinion
A take you're willing to defend without a study to lean on. No "a new report found", no expert name-drop. Reasoning carries the weight. 150–220 words.

### Mode D — Short punchy
Under 120 words. One observation, sharply stated. No setup, no closing question. White space and brevity do the work.

### Mode E — Tactical / how-to
Concrete steps, a checklist, or a small framework someone could apply tomorrow. Bullets or a numbered list are fine here. 150–250 words. Ends with what to try, not a question.

### Mode F — Question-first
Open with the question. Two or three short paragraphs of framing. No definitive answer — invite the discussion. 120–180 words.

## Tagging the angle line
When logging a post to `posts.md`, format the angle line as:
`**Angle:** [Mode X] one-line description`

This makes rotation auditable at a glance.

## Hard limits across all modes
- Max 3–5 hashtags, relevant only
- No em dashes (—)
- No AI-tells: "It's worth noting", "In today's landscape", "Let's dive in", "the reality is", overly polished sentence rhythm where every paragraph is the same length
- Don't lean on a named expert or study in more than 2 of every 5 posts
- Don't open with a percentage in more than 2 of every 5 posts
- Don't end with a question in more than 3 of every 5 posts

## What to avoid
- Generic "thought leadership" platitudes
- Lists of 5 things without substance
- The "you'd expect X, but actually Y" reframe more than once per 5 posts — it's a strong shape, but it's been overused

---

*This is the default style guide. On `initialize pokalai`, it is copied to `instance/config/style-guide.md` where you can customize it freely without affecting the committed version.*
