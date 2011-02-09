package com.sqliagency.as3.collections
{
	import com.sqliagency.as3.core.ICloneable;
	import com.sqliagency.as3.core.IDisposable;
	import com.sqliagency.as3.utils.ArrayUtil;
	import com.sqliagency.as3.utils.ObjectUtil;

	/**
	 * ArrayList
	 * @author Nicolas CHENG (sqliagency)
	 */
	public class ArrayList extends AbstractList implements IList, ICloneable, IDisposable
	{	
		protected var source:Array;
		
		public function ArrayList()
		{
			source = [];
		}
		
		override public function size():int
		{
			return source.length;
		}
		
		override public function getAt(index:int):*
		{
			if (isOutOfRange(index))
			{
				throwRangeError();
				return null;
			}
			
			return source[index];
		}
		
		override public function setAt(e:*, index:int):*
		{
			if (isOutOfRange(index))
			{
				throwRangeError();
				return null;
			}
			
			var previousElt:* = source[index];
			
			source[index] = e;
			
			return previousElt;
		}
		
		override public function add(e:*):Boolean
		{
			source.push(e);
			return true;
		}
		
		override public function addAt(e:*, index:int):void
		{
			// sans condition : un index < 0 insère un élément en partant de la fin du tableau
			source.splice(index, 0, e);
		}
		
		override public function removeAt(index:int):*
		{
			if (isOutOfRange(index))
			{
				throwRangeError();
				return null;
			}
			
			return source.splice(index, 1)[0];
		}
		
		override public function subList(fromIndex:int, toIndex:int):IList
		{
			if (isOutOfRange(fromIndex) || isOutOfRange(toIndex))
			{
				throwRangeError();
				return null;
			}
			else if (fromIndex > toIndex)
			{
				throw new ArgumentError("L'index fromIndex est supérieur à l'index toIndex.");
				return null;
			}
			
			var src:Array = ArrayUtil.clone(source).slice(fromIndex, toIndex);
			return ArrayList.wrap(src);
		}
		
		public function clone():*
		{
			return ArrayList.wrap(ArrayUtil.clone(source));
		}
		
		public function dispose():void
		{
			source = null;
		}
		
		override public function clear():void
		{
			source = [];
		}
		
		protected function isOutOfRange(index:int):Boolean
		{
			var bool:Boolean = index < 0 || index >= size();
			
			return bool;
		}
		
		protected function throwRangeError():void
		{
			throw new RangeError("L'index est en dehors des limites.");
		}
		
		public static function wrap(source:Array):IList
		{
			var list:IList = new ArrayList();
			
			if (!source)
				return list;
			
			for (var i:int = 0; i < source.length; i++)
			{
				list.add(source[i]);
			}
			
			return list;
		}
		
		override public function toArray():Array
		{
			return ArrayUtil.clone(source);
		}
		
		/*
		public function addAllAt(c:ICollection, index:int):Boolean
		{
			if (isOutOfRange(index))
			{
				throwRangeError();
				return false;
			}
			
			if (c.size() == 0)
			{
				return false;
			}
			else
			{
				if (index+1 == size())
				{
					addAll(c);
				}
				else
				{
					var endArray:Array = source.slice(index+1, size()-1);
					source = source.slice(0, index).concat(c.toArray()).concat(endArray);
				}
				return true;
			}
		}
		
		public function addAll(c:ICollection):Boolean
		{
			if (c.size() == 0)
			{
				return false;
			}
			else
			{
				source = source.concat(c.toArray());
				return true;
			}
		}
		
		public function contains(e:*):Boolean
		{
			return (indexOf(e) > -1);
		}
		
		public function containsAll(c:ICollection):Boolean
		{
			var bool:Boolean = true;
			var src:Array = c.toArray();
			
			for (var i:int = 0; i < src.length; i++)
			{
				bool = bool && contains(src[i]);
				if (!bool) break;
			}
			
			return bool;
		}
		
		public function remove(e:*):Boolean
		{
			var index:int = indexOf(e);
			
			var contains:Boolean = index > -1;
			
			if (contains)
			{
				removeAt(index);
			}
			
			return contains;
		}
		
		public function removeAll(c:ICollection):Boolean
		{
			var bool:Boolean = c.size() > 0;
			
			var src:Array = c.toArray();
			
			for (var i:int = 0; i < src.length; i++)
			{
				remove(src[i]);
			}
			
			return bool;
		}
		
		public function retainAll(c:ICollection):Boolean
		{
			var bool:Boolean = c.size() > 0;
			
			if (bool)
			{
				source = c.toArray();
			}
			
			return bool;
		}
		*/
	}
}