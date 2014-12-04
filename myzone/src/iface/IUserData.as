package src.iface 
{
	import src.data.UserDto;
	
	/**
	 * ...
	 * @author Will Jiang
	 */
	public interface IUserData 
	{
		function getCurrentUser(id:int):UserDto;
	}
	
}