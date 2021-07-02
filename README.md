# BookCompetition
Simple functions to extract comments from youtube video and pick winners at random.

## How to use

1. Load the functions into PowerShell
```PowerShell
. .\BookCompetition.ps1
```
2. Collect the competition entries
```PowerShell
$entries = Get-CompetitionEntries -videoId {the Id of the video you want} -apiKey {your youtube api key}
```
3. Generate winners
```PowerShell
# one winner
Get-CompetitionWinner -entries $entries
# five winners
Get-CompetitionWinner -entries $entries -winnerCount 5
# fifty winners
Get-CompetitionWinner -entries $entries -winnerCount 50
```

![BookCompetition](https://user-images.githubusercontent.com/33951277/124230726-c000a100-db52-11eb-8dfc-df5f5a9dcf16.gif)
