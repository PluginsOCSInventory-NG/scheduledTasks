$scheduleTasks = schtasks /query /FO CSV /v /NH

$xml = "";
foreach($scheduleTask in $scheduleTasks) {
    $columns = $scheduleTask.Split('",')

    $xml += "<SCHEDULEDTASKS>`n"
    $xml += "<NAME>" + $columns[4] + "</NAME>`n"
    $xml += "<NEXTEXECHOUR>" + $columns[7] + "</NEXTEXECHOUR>`n"
    $xml += "<STATE>" + $columns[10] + "</STATE>`n"
    $xml += "<LASTEXECHOUR>" + $columns[16] + "</LASTEXECHOUR>`n"
    $xml += "<LASTRESULT>" + $columns[19] + "</LASTRESULT>`n"
    $xml += "<CREATOR>" + $columns[22] + "</CREATOR>`n"
    $xml += "<PLANNING>" + $columns[52] + "</PLANNING>`n"
    $xml += "<TASKTOEXECUTE>" + $columns[25] + "</TASKTOEXECUTE>`n"
    $xml += "<STARTIN>" + $columns[28] + "</STARTIN>`n"
    $xml += "<COMMENT>" + $columns[31] + "</COMMENT>`n"
    $xml += "<TASKSTATUS>" + $columns[34] + "</TASKSTATUS>`n"
    $xml += "<TYPE>" + $columns[55] + "</TYPE>`n"
    $xml += "<BEGINHOUR>" + $columns[58] + "</BEGINHOUR>`n"
    $xml += "<BEGINDATE>" + $columns[61] + "</BEGINDATE>`n"
    $xml += "<ENDDATE>" + $columns[64] + "</ENDDATE>`n"
    $xml += "<DAY>" + $columns[67] + "</DAY>`n"
    $xml += "<MONTH>" + $columns[70] + "</MONTH>`n"
    $xml += "<EXECUTEAS>" + $columns[43] + "</EXECUTEAS>`n"
    $xml += "<DELTASK>" + $columns[46] + "</DELTASK>`n"
    $xml += "<STOPTASKAFTER>" + $columns[49] + "</STOPTASKAFTER>`n"
    $xml += "</SCHEDULEDTASKS>`n"
}

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::WriteLine($xml)