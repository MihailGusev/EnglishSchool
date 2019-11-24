package mainApp.dao;

import mainApp.entity.Role;

public interface RoleDao {
    public Role findRoleByName(String roleName);
}
