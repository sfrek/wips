RADOS (Reliable, Autonomic Distributed Object Store)
====================================================

* preserves consistent data access and strong safety semantics while allowing nodes to act semi-autonomously to selfmanage replication, failure detection, and failure recovery through the use of a small cluster map.
* seeks to leverage device intelligence to distribute the complexity surrounding consistent data access, redundant storage, failure detection, and failure recovery in clusters consisting of many thousands of storage devices.
* facilitates an evolving, balanced distribution of data and workload across a dynamic and heterogeneous storage cluster while providing applications with the illusion of a single logical object store with well-defined safety semantics and strong consistency guarantees.


```
operador@Ceph01:~$ cat /etc/ceph/ceph.conf 
[osd]
	osd journal size = 1000
	filestore xattr use omap = true

[mon.a]
	host = Ceph01
	mon addr = 192.168.213.11:6789

[osd.0]
	host = Ceph01

[osd.1]
	host = Ceph01

[mds.a]
	host = Ceph01
```


```
operador@Ceph01:/etc/ceph$ sudo mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring
temp dir is /tmp/mkcephfs.oE7wZaZ5r3
preparing monmap in /tmp/mkcephfs.oE7wZaZ5r3/monmap
/usr/bin/monmaptool --create --clobber --add a 192.168.213.11:6789 --print /tmp/mkcephfs.oE7wZaZ5r3/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.oE7wZaZ5r3/monmap
/usr/bin/monmaptool: generated fsid 9c9bb919-c593-4519-a57f-f2c0c79d92e1
epoch 0
fsid 9c9bb919-c593-4519-a57f-f2c0c79d92e1
last_changed 2012-12-17 17:48:13.293162
created 2012-12-17 17:48:13.293162
0: 192.168.213.11:6789/0 mon.a
/usr/bin/monmaptool: writing epoch 0 to /tmp/mkcephfs.oE7wZaZ5r3/monmap (1 monitors)
=== osd.0 === 
2012-12-17 17:48:13.391728 7fa92f7c2780 -1 filestore(/var/lib/ceph/osd/ceph-0) limited size xattrs -- filestore_xattr_use_omap enabled
2012-12-17 17:48:13.511975 7fa92f7c2780 -1 filestore(/var/lib/ceph/osd/ceph-0) could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
2012-12-17 17:48:13.565799 7fa92f7c2780 -1 created object store /var/lib/ceph/osd/ceph-0 journal /var/lib/ceph/osd/ceph-0/journal for osd.0 fsid 9c9bb919-c593-4519-a57f-f2c0c79d92e1
2012-12-17 17:48:13.565862 7fa92f7c2780 -1 auth: error reading file: /var/lib/ceph/osd/ceph-0/keyring: can't open /var/lib/ceph/osd/ceph-0/keyring: (2) No such file or directory
2012-12-17 17:48:13.565954 7fa92f7c2780 -1 created new key in keyring /var/lib/ceph/osd/ceph-0/keyring
=== osd.1 === 
2012-12-17 17:48:13.641061 7f2b9f2bc780 -1 filestore(/var/lib/ceph/osd/ceph-1) limited size xattrs -- filestore_xattr_use_omap enabled
2012-12-17 17:48:13.671259 7f2b9f2bc780 -1 filestore(/var/lib/ceph/osd/ceph-1) could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
2012-12-17 17:48:13.737323 7f2b9f2bc780 -1 created object store /var/lib/ceph/osd/ceph-1 journal /var/lib/ceph/osd/ceph-1/journal for osd.1 fsid 9c9bb919-c593-4519-a57f-f2c0c79d92e1
2012-12-17 17:48:13.737365 7f2b9f2bc780 -1 auth: error reading file: /var/lib/ceph/osd/ceph-1/keyring: can't open /var/lib/ceph/osd/ceph-1/keyring: (2) No such file or directory
2012-12-17 17:48:13.737420 7f2b9f2bc780 -1 created new key in keyring /var/lib/ceph/osd/ceph-1/keyring
=== mds.a === 
creating private key for mds.a keyring /var/lib/ceph/mds/ceph-a/keyring
creating /var/lib/ceph/mds/ceph-a/keyring
Building generic osdmap from /tmp/mkcephfs.oE7wZaZ5r3/conf
/usr/bin/osdmaptool: osdmap file '/tmp/mkcephfs.oE7wZaZ5r3/osdmap'
/usr/bin/osdmaptool: writing epoch 1 to /tmp/mkcephfs.oE7wZaZ5r3/osdmap
Generating admin key at /tmp/mkcephfs.oE7wZaZ5r3/keyring.admin
creating /tmp/mkcephfs.oE7wZaZ5r3/keyring.admin
Building initial monitor keyring
added entity mds.a auth auth(auid = 18446744073709551615 key=AQDNTM9QuHMoLhAASIEZAV5kDTlxXo02an9oMg== with 0 caps)
added entity osd.0 auth auth(auid = 18446744073709551615 key=AQDNTM9QKGq6IRAAae+kDuGKqlNJQ0EONqW5zQ== with 0 caps)
added entity osd.1 auth auth(auid = 18446744073709551615 key=AQDNTM9Q2FPzKxAA7HHcr/dn/ceGzzj7XnHAKA== with 0 caps)
=== mon.a === 
/usr/bin/ceph-mon: created monfs at /var/lib/ceph/mon/ceph-a for mon.a
placing client.admin keyring in ceph.keyring
```

```
operador@Ceph01:~$ sudo service ceph start
=== mon.a === 
Starting Ceph mon.a on Ceph01...
starting mon.a rank 0 at 192.168.213.11:6789/0 mon_data /var/lib/ceph/mon/ceph-a fsid 9c9bb919-c593-4519-a57f-f2c0c79d92e1
=== mds.a === 
Starting Ceph mds.a on Ceph01...
starting mds.a at :/0
=== osd.0 === 
Starting Ceph osd.0 on Ceph01...
starting osd.0 at :/0 osd_data /var/lib/ceph/osd/ceph-0 /var/lib/ceph/osd/ceph-0/journal
=== osd.1 === 
Starting Ceph osd.1 on Ceph01...
starting osd.1 at :/0 osd_data /var/lib/ceph/osd/ceph-1 /var/lib/ceph/osd/ceph-1/journal
```

