#pragma once

#include <list>
#include <algorithm>

#ifdef _WIN32
   #include <hash_map>
   #include <hash_set>
#else
   #include <cstring>
   #include <iostream>
	//#include <map>
	//#include <set>
	// the following are if we want to use the hash versions of map and set
		// instead of the tree versions that are included above
   #include <ext/hash_map>
   #include <ext/hash_set>
#endif

template <class Key, class Hash, class Compare>
class HashTraitsInteropReplacement
{
   Hash h;
   Compare c;
public:
   static const size_t bucket_size = 4;
   static const size_t min_buckets = 8;
   HashTraitsInteropReplacement( )
   {}
   HashTraitsInteropReplacement( Compare pred )
      : c(pred)
   {}
   size_t operator( )( const Key& k ) const
   {
      return h(k);
   }
   bool operator( )(const Key& k1, const Key& k2) const
   {
      return c(k1,k2);
   }
};

template <class T>
class HashInteropReplacement
{
public:
   size_t operator()(const T& v) const
   {
      return (size_t) v;
   }
};

template <>
class HashInteropReplacement<char*>
{
public:
   size_t operator()(const char* v) const
   {
      return (size_t)(v[0]);
   }
};

template <>
class HashInteropReplacement<std::string>
{
public:
   size_t operator()(const std::string& s) const
   {
      return (size_t)(s[0]) + s.size();
   }
};

#ifdef _WIN32
template <class Key,class Val,class Hash=HashInteropReplacement<Key>,class Comparator=std::less<Key>>
   class HashMap:public stdext::hash_map<Key,Val,HashTraitsInteropReplacement<Key,Hash,Comparator>>{};
template <class Key, class Hash = HashInteropReplacement<Key>, class Comparator = std::less<Key>>
   class HashSet : public stdext::hash_set<Key,HashTraitsInteropReplacement<Key, Hash,Comparator>>{};
template<class Key,class Val,class Hash=HashInteropReplacement<Key>,class Comparator=std::less<Key>>
   class HashMultiMap:public stdext::hash_multimap<Key,Val,HashTraitsInteropReplacement<Key,Hash,Comparator>>{};
#else
/*
 * the following is the code for using the regular black-red tree map in std instead of hashmap
template <class Key, class Val, class Hash = HashInteropReplacement<Key>, class Comparator = std::less<Key> >
	class HashMap : public std::map<Key, Val, Comparator>{};
template <class Key, class Hash = HashInteropReplacement<Key>, class Comparator = std::less<Key> >
	class HashSet : public  std::set<Key, Comparator>{};
template <class Key, class Val, class Hash = HashInteropReplacement<Key>, class Comparator = std::less<Key> >
			class HashMultiMap : public std::multimap<Key,Val,Comparator>{};
			*/
/*
 * the following is code that was used when I used hash_map and hash_set
 * instead of map and set. They have some extra code for converting the
 * contents of the map or set to arrays to aid gdb in debugging,
 * because gdb can't dereference hash_map and hash_set that well
 */
template <class Key, class Compare> class EqualKeyReplacement
{
	Compare lessThan;
public:
	bool operator() (const Key& k1, const Key& k2) const
	{
		// simulate equals(k1,k2) using the Comparator
		return !(lessThan(k1,k2) || lessThan(k2,k1));
	}
};
template <class Key, class Val, class Hash = HashInteropReplacement<Key>, class Comparator = std::less<Key> >
class HashMap : public __gnu_cxx::hash_map<Key, Val, Hash, EqualKeyReplacement <Key,Comparator> >
{
public:
	void convertToArray(Val myValArray [], size_t arraySize)
	{
		typename HashMap<Key,Val>::const_iterator myIterator;
		size_t i;

		// zero out memory first
		memset(myValArray,0,sizeof(Val) * arraySize);

		i = 0;
		for (myIterator=this->begin(); myIterator!=this->end(); ++myIterator)
		{
			if (i<arraySize)
			{
				myValArray[i] = myIterator->second;
			}
			i++;
		}
		if (i>arraySize)
		{
			std::cout << "HashContainers::HashMap::convertToArray: arraySize "
					<< arraySize << " is smaller than hashMapSize "
					<< i << std::endl;
		}
		return ;
	}
};
template <class Key, class Hash = HashInteropReplacement<Key>, class Comparator = std::less<Key> >
class HashSet : public  __gnu_cxx::hash_set<Key, Hash, EqualKeyReplacement <Key,Comparator> >
{
public:
	void convertToArray(Key myKeyArray [], size_t arraySize)
	{
		typename HashSet<Key>::const_iterator myIterator;
		size_t i;

		// zero out memory first
		memset(myKeyArray,0,sizeof(Key) * arraySize);

		i = 0;
		for (myIterator=this->begin(); myIterator!=this->end(); ++myIterator)
		{
			if (i < arraySize)
			{
				myKeyArray[i] = *myIterator;
			}
			i++;
		}
		if (i>arraySize)
		{
			std::cout << "HashContainers::HashSet::convertToArray: arraySize "
					<< arraySize << " is smaller than hashSetSize "
					<< i << std::endl;
		}
		return;
	}
};
template <class Key, class Val, class Hash = HashInteropReplacement<Key>, class Comparator = std::less<Key> >
class HashMultiMap:public __gnu_cxx::hash_multimap<Key,Val,Hash,EqualKeyReplacement<Key,Comparator> >
{
public:
	void convertToArray(Val myValArray [], size_t arraySize)
	{
		typename HashMap<Key,Val>::const_iterator myIterator;
		size_t i;

		// zero out memory first
		memset(myValArray,0,sizeof(Val) * arraySize);

		i = 0;
		for (myIterator=this->begin(); myIterator!=this->end(); ++myIterator)
		{
			if (i<arraySize)
			{
				myValArray[i] = myIterator->second;
			}
			i++;
		}
		if (i>arraySize)
		{
			std::cout << "HashContainers::HashMap::convertToArray: arraySize "
					<< arraySize << " is smaller than hashMapSize "
					<< i << std::endl;
		}
		return;
	}
};
template <typename T>
void convertVectorToArray(std::vector<T>& myVector,T myTArray[], size_t arraySize)
{
	typename std::vector<T>::const_iterator myIterator;
	size_t i;

	// zero out memory first
	memset(myTArray, 0, sizeof(T) * arraySize);

	i = 0;
	for (myIterator = myVector.begin(); myIterator != myVector.end(); ++myIterator)
	{
		if (i<arraySize)
		{
			myTArray[i] = *myIterator;
		}
		i++;
	}
	if (i>arraySize)
	{
		std::cout << "HashContainers::convertVectorToArray: arraySize "
				<< arraySize << " is smaller than vectorSize "
				<< i << std::endl;
	}
	return;
}
#endif // else !defined _WIN32
