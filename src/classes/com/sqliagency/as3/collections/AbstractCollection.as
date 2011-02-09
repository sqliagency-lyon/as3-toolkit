package com.sqliagency.as3.collections
{
	import com.sqliagency.as3.utils.ArrayUtil;
	
	import flash.errors.IllegalOperationError;

	/**
	 * AbstractCollection
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class AbstractCollection implements ICollection
	{
		/**
		 * Constructeur.
		 */
		public function AbstractCollection()
		{
			if (Object(this).constructor === AbstractCollection)
			{
				throw new IllegalOperationError("AbstractCollection must not be directly instantiated.");
			}
		}
		
		public function add(e:*):Boolean
		{
			throw new IllegalOperationError("Opération invalide.");
			return false;
		}
		
		public function addAll(c:ICollection):Boolean
		{
			var modified:Boolean = false;
			
			var itr:IIterator = c.getIterator();

			while (itr.hasNext())
			{
				if (add(itr.next()))
					modified = true;
			}
			return modified;
		}
		
		public function clear():void
		{
			var itr:IIterator = getIterator();
			
			while (itr.hasNext())
			{
				itr.next();
				itr.remove();
			}
		}
		
		public function contains(e:*):Boolean
		{
			var itr:IIterator = getIterator();
			
			while (itr.hasNext())
			{
				if (itr.next()===e)
					return true;
			}
			
			return false;
		}
		
		public function containsAll(c:ICollection):Boolean
		{
			var itr:IIterator = c.getIterator();
			
			while (itr.hasNext())
			{
				if (!contains(itr.next()))
					return false;
			}
			
			return true;
		}
		
		public function isEmpty():Boolean
		{
			return (size() == 0);
		}
		
		public function remove(e:*):Boolean
		{
			var itr:IIterator = getIterator();
			
			while (itr.hasNext())
			{
				if (itr.next()===e) 
				{
					itr.remove();
					return true;
				}
			}
			
			return false;
		}
		
		public function removeAll(c:ICollection):Boolean
		{
			var modified:Boolean = false;
			var itr:IIterator = getIterator();
			
			while (itr.hasNext())
			{
				if (c.contains(itr.next()))
				{
					itr.remove();
					modified = true;
				}
			}
			
			return modified;
		}
		
		public function retainAll(c:ICollection):Boolean
		{
			var modified:Boolean = false;
			var itr:IIterator = getIterator();
			
			while (itr.hasNext())
			{
				if (!c.contains(itr.next())) 
				{
					itr.remove();
					modified = true;
				}
			}
			return modified;
		}
		
		public function size():int
		{
			throw new IllegalOperationError("Opération invalide.");
			return 0;
		}
		
		public function toArray():Array
		{
			var r:Array = [];
			var itr:IIterator = getIterator();
			
			while(itr.hasNext())
			{
				r.push(itr.next());
			}
			
			// clone pour plus de sureté
			return ArrayUtil.clone(r);
		}
		
		public function getIterator():IIterator
		{
			throw new IllegalOperationError("Opération invalide.");
			return null;
		}
	}
}