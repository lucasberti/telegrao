do

function run(msg, matches)
  local answers = {'ma con certesa!','ta disidido q simn','100 duvida',
                  'ma e definitivamente 1 si','pd ter sertea','to veno q simn',
                  'mt provavuetmentet','parese bon','s','td dis q s',
                  'hum sei n, pregunta dps','mlrh pergneta dps',
                  'n vo temfla agr mlh n','agr n da pradise',
                  'CONCETRA DIRETO E DPS PERGUNT NDEONV','n comtecom isto',
                  'a rpesita e nao','me flaaram q n','hmm n parese bmo',
                  'mei difisl'}
  return answers[math.random(#answers)]
end

return {
  description = "Magic 8Ball",
  usage = "!magic8ball",
  patterns = {
    "^!bolinha",
    "^/bolinha" },
  run = run
}

end
