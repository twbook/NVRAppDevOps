function Test-ALApp
{
    param (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$True)]
        $ContainerName=$env:ContainerName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$True)]
        $ClientPath,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$True)]
        $TestCodeunitId,
        [Parameter(Mandatory=$true)]
        $TrxFile,
        [switch]$ErrorOnFailedTest
    )

    Run-ALTest -ContainerName $ContainerName -ClientPath $ClientPath -TestCodeunitId $TestCodeunitId
    $result = (Read-ALTestResult -ContainerName $ContainerName | Convert-ALTestResultToTrxResult -TrxFile $TrxFile)
    if ($ErrorOnFailedTest -and ($result.TestRun.ResultSummary.Counters.failed -gt 0)) {
        Write-Error "There is $($result.TestRun.ResultSummary.Counters.failed) failing tests!"
    }
}