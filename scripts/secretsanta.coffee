getRandomInt = (min, max) ->
  min = Math.ceil min
  max = Math.floor max
  return Math.floor(Math.random() * (max - min + 1)) + min

getRandomElement = (list) ->
  i = getRandomInt(0, list.length-1)
  elem = list[i]
  newlist = list.filter (item) -> item isnt elem
  [elem, newlist]

arrShuffle = (arr) ->
    i = arr.length;
    if i == 0 then return false
    while --i
        j = Math.floor(Math.random() * (i+1))
        tempi = arr[i]
        tempj = arr[j]
        arr[i] = tempj
        arr[j] = tempi
    return arr

secretsanta = (list) ->
  l = arrShuffle(list)
  r = []
  for who in list
    [give, l] = getRandomElement(l)
    if who == give
      until who != give
        l.push give
        [give, l] = getRandomElement(l)
    r.push [who,give]
  r

module.exports = (robot) ->
  robot.respond /secretsanta (.*)/i, (res) ->
    # peeps = ["cole", "mikey", "eve", "grace", "bill", "mom", "dad", "mina","marley","bitty"]
    for [giver, receiver] in secretsanta(res.match)
      console.log(giver+" -> "+receiver)
      robot.send giver "You are #{receiver}'s Secret Santa"