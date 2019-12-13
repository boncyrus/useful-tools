echo "Found xUnit test projects:"
find $APPCENTER_SOURCE_DIRECTORY -regex '.*Tests.*\.csproj' -exec echo {} \;
echo
echo "Running xUnit tests:"
find $APPCENTER_SOURCE_DIRECTORY -regex '.*Tests.*\.csproj' -exec dotnet test '-l:trx;LogFileName=TestOutput.xml' {} \;
echo
echo "xUnit tests result:"
pathOfTestResults=$(find $APPCENTER_SOURCE_DIRECTORY -name 'TestOutput.xml')

#look for a failing test
grep -q 'outcome="Failed"' $pathOfTestResults

if [[ $? -eq 0 ]]
then 
echo "A test Failed" 
exit 1
else 
echo "All tests passed" 
fi