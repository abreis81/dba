Rollback Segments

Here are some scripts related to Rollback Segments .
Segments

ROLLBACK INFORMATION NOTES:
# Segment Name - Name of the rollback segment.
# Owner - Owner of the rollback segment.
# Tablespace - Name of the tablespace containing the rollback segment.
# Segment ID - ID number of the rollback segment.
# File ID - ID number of the block containing the segment header.
# Block ID - Starting block number of the extent.
# Initial Extent - Initial extent size in bytes.
# Next Extent - Secondary extent size in bytes.
# Min Extents - Minimum number of extents.
# Max Extents - Maximum number of extents.
# PCT Increase - Percent increase for extent size.
# Status - ONLINE if the segment is online, or PENDING OFFLINE if the segment is going offline but some active (distributed) transactions are using the rollback segment. When the transaction(s) complete, the segment goes OFFLINE.
# Instance - Instance this rollback segment belongs to (Parallel Server), or NULL for a single-instance system .

    select 	SEGMENT_NAME,
    	OWNER,
    	TABLESPACE_NAME,
    	SEGMENT_ID,
    	FILE_ID,
    	BLOCK_ID,
    	INITIAL_EXTENT,
    	NEXT_EXTENT,
    	MIN_EXTENTS,
    	MAX_EXTENTS,
    	PCT_INCREASE,
    	STATUS,
    	INSTANCE_NUM
    from 	dba_rollback_segs
    order	by SEGMENT_NAME


Transactions

ROLLBACK STATISTIC (TRANSACTION TABLES) NOTES:
# Statistic Name - Name of the statistic
# Value - Current value

# The name of the consistent changes statistic is misleading. It does not indicate the number of updates (or changes), but rather, the number of times a consistent get had to retrieve and "old" version of a block because of updates that occurred after the cursor had been opened. As of Oracle7.3, a more accurate statistic was added. Named data blocks consistent reads - undo records applied; the new statistic gives the actual number of data records applied.
# The consistent gets statistic reflects the number of accesses made to the block buffer to retrieve data in a consistent mode. Most accesses to the buffer are done with the consistent get mechanism, which uses the SCN (System Change Number) to make sure the data being read has not changed sine the query was started.
# The data blocks consistent reads - undo records applied statistic reflects the number of updates (or changes) applied.

    select NAME,
           VALUE
    from   v$sysstat
    where  name in (
           'consistent gets',
           'consistent changes',
           'transaction tables consistent reads - undo records applied',
           'transaction tables consistent read rollbacks',
           'data blocks consistent reads - undo records applied',
           'no work - consistent read gets',
           'cleanouts only - consistent read gets',
           'rollbacks only - consistent read gets',
           'cleanouts and rollbacks - consistent read gets')
    order  by NAME


Contention

ROLLBACK CONTENTION NOTES:
# Segment Name - Name of the rollback segment.
# Seg# - Rollback segment number.
# Gets - Number of header gets.
# Waits - Number of header waits.
# Hit Ratio - Ratio of gets to waits. This should be >= 99%.
# Active Transactions - Number of active transactions.
# Writes - Number of bytes written to rollback segment.

# Hit Ratio should be >= 99% - if not, consider adding additional rollback segments.
# Check the system undo header, system undo block, undo header, undo block statistics under "Wait Statistics" for additional information on rollback contention.
#

    select 	b.NAME,
    	a.USN seg#,
    	GETS,
    	WAITS,
    	round(((GETS-WAITS)*100)/GETS,2) hit_ratio,
    	XACTS active_transactions,
    	WRITES
    from	v$rollstat a,
    	v$rollname b
    where	a.USN = b.USN;


Growth

ROLLBACK EXTENDING AND SHRINKAGE NOTES:
# Rollback Segment - Name of rollback segment.
# Seg# - Rollback segment number.
# Size - Size in bytes of the rollback segment.
# OptSize - Optimal size of rollback segment.
# HWM - High Water Mark of rollback segment size.
# Extends - Number of times rollback segment was extended to have a new extent.
# Wraps - Number of times rollback segment wraps from one extent to another.
# Shrinks - Number of times rollback segment shrank, eliminating one or more additional extents each time.
# Average Shrink - Total size of freed extents divided by number of shrinks.
# Average Active - Current average size of active extents, where "active" extents have uncommitted transaction data.
# Status - ONLINE if the segment is online, or PENDING OFFLINE if the segment is going offline but some active (distributed) transactions are using the rollback segment. When the transaction(s) complete, the segment goes OFFLINE.

    select 	NAME,
    	a.USN,
    	RSSIZE,
    	OPTSIZE,
    	HWMSIZE,
    	EXTENDS,
    	WRAPS,
    	SHRINKS,
    	AVESHRINK,
    	AVEACTIVE,
    	STATUS
    from 	v$rollstat a , 
    	v$rollname b
    where 	a.USN=b.USN
    order	by NAME

