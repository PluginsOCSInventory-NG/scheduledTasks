
 
package Apache::Ocsinventory::Plugins::Scheduledtasks::Map;
 
use strict;
 
use Apache::Ocsinventory::Map;

$DATA_MAP{scheduledtasks} = {
		mask => 0,
        	multi => 1,
        	auto => 1,
        	delOnReplace => 1,
        	sortBy => 'NAME',
        	writeDiff => 0,
        	cache => 0,
        	fields => {
        		NAME => {},
        		NEXTEXECHOUR => {},
        		STATE => {},
        		LASTEXECHOUR => {},
        		LASTRESULT => {},
        		CREATOR => {},
        		PLANNING => {},
        		TASKTOEXECUTE => {},
        		STARTIN  => {},
        		COMMENT => {},
        		TASKSTATUS => {},
        		TYPE => {},
        		BEGINHOUR => {},
        		BEGINDATE => {},
        		ENDDATE => {},
        		DAY => {},
        		MONTH => {},
        		EXECUTEAS => {},
        		DELTASK => {},
        		STOPTASKAFTER => {}
}
};
1;
