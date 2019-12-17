h:hopen`::5001; /* connect to rdb */

m:{h"select match_id,home_team,away_team,home,draw,away,home_score,away_score from get_all_matches_state()"}

\p 5002

.z.ws:{value x};
.z.wc: { delete from `subs where handle=x};

subs:2!flip `handle`func`params!"is*"$\:();

sub:{`subs upsert(.z.w;x;enlist y)};

loadPage:{ getMatches[.z.w]; sub[`putMatchUpdate;enlist `]}

getMatches:{ (neg[x]) .j.j `func`result!(`getMatches;m())}

putMatchUpdate:{`func`result!(`putMatchUpdate; h"select match_id,home_team,away_team,home,draw,away,home_score,away_score value queue")}

pub:{
 row:(0!subs)[x];
 (neg row[`handle]) .j.j (value row[`func])[row[`params]];
 };

.z.ts:{
 pub each til count subs;
 h"clean_queue()";
 };
\t 1000




