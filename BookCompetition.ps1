#region Functions
function Get-CompetitionEntries {
    [cmdletbinding()]
    param(
        [string]$videoId,
        [string]$apiKey
    )
    $dataUri = 'https://www.googleapis.com/youtube/v3/commentThreads?videoId={0}&key={1}&textFormat=plainText&part=snippet&maxResults=100' -f $videoId, $apiKey

    $videoCommentThreads = Invoke-RestMethod -Method Get -Uri $dataUri

    [System.Collections.ArrayList]$tickets = 0..$($videoCommentThreads.items.count - 1) | Get-Random -Shuffle

    [System.Collections.ArrayList]$entries = for ($i = 0; $i -le $($videoCommentThreads.items.count - 1); $i++) {
        $comment = $videoCommentThreads.items.snippet.topLevelComment.snippet[$i]
        [PSCustomObject]@{
            Author        = $comment.authorDisplayName
            AuthorProfile = $comment.authorChannelUrl
            ticket        = $tickets[$i]
        }
    }
    return $entries
}

function Get-CompetitionWinner {
    [cmdletbinding()]
    param (
        [System.Collections.ArrayList]$entries,
        [int]$winnerCount = 1
    )
    $tickets = $entries.ticket | Get-Random -Shuffle
    $winners = if ($winnerCount -gt 1) {
        (0..($winnerCount - 1)) | ForEach-Object {
            $winningTicket = $tickets[$_]
            $entries | Where-Object ticket -EQ $winningTicket
        }
    }
    else {
        $winningTicket = $tickets | Get-Random
        $entries | Where-Object ticket -eq $winningTicket
    }
    return $winners
}
#endregion
