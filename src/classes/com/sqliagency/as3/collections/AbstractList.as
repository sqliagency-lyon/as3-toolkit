package com.sqliagency.as3.collections
{
	import flash.errors.IllegalOperationError;

	/**
	 * AbstractList
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class AbstractList extends AbstractCollection implements IList
	{
		/**
		 * Constructeur.
		 */
		public function AbstractList()
		{
			if (Object(this).constructor === AbstractList)
			{
				throw new IllegalOperationError("AbstractList must not be directly instantiated.");
			}
		}
		
		override public function add(e:*):Boolean
		{
			addAt(e, size());
			return true;
		}
		
		public function getAt(index:int):*
		{
			throw new IllegalOperationError("Opération illégale.");
			return null;
		}
		
		public function setAt(e:*, index:int):*
		{
			throw new IllegalOperationError("Opération illégale.");
			return null;
		}
		
		public function addAt(e:*, index:int):void
		{
			throw new IllegalOperationError("Opération illégale.");
			return;
		}
		
		public function removeAt(index:int):*
		{
			throw new IllegalOperationError("Opération illégale.");
			return null;
		}
		
		public function indexOf(o:Object):int
		{
			var itr:IListIterator = getListIterator();
			
			while (itr.hasNext())
			{
				if (itr.next()===o)
					return itr.previousIndex();
			}
			return -1;
		}
		
		public function lastIndexOf(o:Object):int
		{
			var itr:IListIterator = getListIterator(size());
			
			while (itr.hasPrevious())
			{
				if (itr.previous()===o)
					return itr.nextIndex();
			}
			return -1;
		}
		
		override public function clear():void
		{
			removeRange(0, size());
		}
		
		protected function removeRange(fromIndex:int, toIndex:int):void
		{
			var itr:IListIterator = getListIterator(fromIndex);
			var n:int = toIndex-fromIndex
				
			for (var i:int=0; i < n; i++)
			{
				itr.next();
				itr.remove();
			}
		}
		
		public function addAllAt(c:ICollection, index:int):Boolean
		{
			var modified:Boolean = false;
			var itr:IIterator = c.getIterator();
			
			while (itr.hasNext())
			{
				addAt(itr.next(), index++);
				modified = true;
			}
			
			return modified;
		}
		
		public function subList(fromIndex:int, toIndex:int):IList
		{
			throw new IllegalOperationError("Opération illégale.");
			return null;
		}
		
		public function getListIterator(index:int=0):IListIterator
		{
			return new ListItr(this, index);
		}
		
		override public function getIterator():IIterator
		{
			return new Itr(this);
		}
	}
}

import com.sqliagency.as3.collections.AbstractList;
import com.sqliagency.as3.collections.IIterator;
import com.sqliagency.as3.collections.IList;
import com.sqliagency.as3.collections.IListIterator;

import flash.errors.IllegalOperationError;

internal class Itr implements IIterator
{
	protected var list:IList;
	protected var cursor:int = 0;
	protected var lastRet:int = -1;
	
	public function Itr(list:IList)
	{
		this.list = list;
	}
	
	public function hasNext():Boolean
	{
		return (cursor != list.size());
	}
	
	public function next():*
	{
		try 
		{
			var next:* = list.getAt(cursor);
			lastRet = cursor++;
			return next;
		} 
		catch (err:RangeError)
		{
			throw err;
			return null;
		}
	}
	
	public function remove():void
	{
		if (lastRet == -1)
		{
			throw IllegalOperationError("Opération illégale.");
			return;
		}
		
		try 
		{
			list.removeAt(lastRet);
			
			if (lastRet < cursor)
				cursor--;
			lastRet = -1;
		}
		catch (err:RangeError)
		{
			throw err;
			return;
		}
	}
}

internal class ListItr extends Itr implements IListIterator
{
	public function ListItr(list:IList, index:int)
	{
		super(list);
		cursor = index;
	}
	
	public function add(e:*):void
	{
		try
		{
			list.addAt(e, cursor++);
			lastRet = -1;
		}
		catch (err:RangeError)
		{
			throw err;
			return;
		}
	}
	
	public function hasPrevious():Boolean
	{
		return (cursor != 0);
	}
	
	public function nextIndex():int
	{
		return cursor;
	}
	
	public function previous():*
	{
		try
		{
			var i:int = cursor-1;
			var previous:* = list.getAt(i);
			lastRet = cursor = i;
			return previous;
		} 
		catch (err:RangeError)
		{
			throw err;
			return null;
		}
	}
	
	public function previousIndex():int
	{
		return cursor-1;
	}
	
	public function set(e:*):void
	{
		if (lastRet == -1)
		{
			throw new IllegalOperationError("Opération illégale.");
			return;
		}
		
		try
		{
			list.setAt(e, lastRet);
		} 
		catch (err:RangeError) 
		{
			throw err;
			return;
		}
	}
}