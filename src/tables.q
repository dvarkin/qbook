\p 5001

// create tables

numberOfMatches:300
numberOfGoals: 10
numberOfUpdates: 100
numberOfScores: numberOfMatches * numberOfUpdates
numberOfPrices: numberOfMatches * numberOfUpdates * 50
coefLimits: 10.0
a:`dyno`rick`morty`doom`hell`queen`king`kiss`42

date:.z.p;

show numberOfMatches
show numberOfScores
show numberOfPrices


match: ([]
 match_id:til numberOfMatches;
 ts:numberOfMatches#date*3;
 home_team:numberOfMatches?a;
 away_team:numberOfMatches?a
 )


/// OUTCOMES

market: ([]
 match_id:numberOfPrices ?numberOfMatches;
 ts: numberOfPrices?(.z.p);
 home: 1.01+numberOfPrices?coefLimits;
 draw: 1.01+numberOfPrices?coefLimits;
 away: 1.01+numberOfPrices?coefLimits)

insert_1x2:{[data]
 `market insert(data[`match_id]; .z.p; rand coefLimits; rand coefLimits; rand coefLimits);
 `match_id xasc `market;
 }


score: ([]
 match_id:numberOfScores?numberOfMatches;
 ts:numberOfScores?(.z.p);
 home_score:numberOfScores?numberOfGoals;
 away_score:numberOfScores?numberOfGoals
 )


insert_score:{[data]
 `score insert(data[`match_id]; .z.p; data[`home]; data[`away]);
 `match_id xasc `score;
 }

// Sorts

`match_id xasc `match;
`match_id xasc `market;
`match_id xasc `score;


// JOINS


match_score:{ aj0[`match_id`ts;match;score]}
match_1x2:{ aj0[`match_id`ts;match;market]}

get_match_state:{[m]
 mss: select from match_score() where match_id=m;
 moo: select from match_1x2() where match_id=m;
 mm: select from match where match_id=m;
 1!mm lj 1!moo lj 1!mss
 }

get_all_matches_state: {
 ms:match_score();
 mo:match_1x2();
 1!match lj 1!mo lj 1!ms
 }




// setup JSON decoder
decode:{[j]k:.j.k j;(key k)!j2k[key k]@'value k};
j2k:(enlist `)!enlist (::);
j2k[`match_id]:`int$;
j2k[`home]:`int$;
j2k[`away]:`int$;

//// TEST

j:"{ \"match_id\": 1,  \"home\": 0,  \"away\":0}"
//{"match_id": 1,"home": 0,"away":0}
test_data: decode j

insert_score test_data
insert_1x2 test_data


//d: (`match_id`home`away)! 1 10 10

//select home_team,away_team,home,draw,away,home_score,away_score from get_all_matches_state() where match_id=1
