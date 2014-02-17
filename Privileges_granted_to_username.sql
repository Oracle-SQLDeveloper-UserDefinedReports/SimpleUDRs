select   a.username,
        b.granted_role || decode(admin_option,'YES',' (With Admin Option)',null)
           what_granted
from     sys.dba_users a, sys.dba_role_privs b
where    a.username = b.grantee
         and username=upper(:GRANTEE)
                  UNION
select   a.username,
         b.privilege || decode(admin_option,'YES',' (With Admin Option)',null)
           what_granted
from     sys.dba_users a, sys.dba_sys_privs b
where    a.username = b.grantee
         and username=upper(:GRANTEE)
         UNION
select   a.username,
         b.table_name || ' - ' || b.privilege 
           || decode(grantable,'YES',' (With Grant Option)',null) what_granted
from     sys.dba_users a, sys.dba_tab_privs b
where    a.username = b.grantee 
         and username=upper(:GRANTEE)
order by 1
