xquery version "1.0";

declare function local:find-entrenchment-objects() 
as item()*
{
for $obj in doc("MapInfo.xdb")/MapInfo/Objects/Item
	where starts-with( xs:string($obj/Object/@href), "/entrenchments/" )
	return <Item>{$obj}</Item>
};

declare function local:find-entrenchment-indices()
as item()*
{
for $obj in doc("MapInfo.xdb")/MapInfo/Entrenchments/Item/sections/Item/data/Item
	return $obj
};

declare function local:find-invalid-entrenchment-entries()
as item()*
{
let $allEntrs := local:find-entrenchment-objects()
let $allIdices := local:find-entrenchment-indices()
for $entry in $allEntrs/Item/Link/LinkID
	where empty(index-of( $allIdices, $entry ))
	order by xs:integer($entry) ascending
	return <Entry>{$entry}</Entry>
};

declare function local:find-invalid-entrenchment-indices()
as item()*
{
let $allEntrs := local:find-entrenchment-objects()
let $allIdices := local:find-entrenchment-indices()
for $idx in $allIdices
	where empty(index-of( $allEntrs/Item/Link/LinkID, $idx ))
	order by xs:integer($idx) ascending
	return <Index>{$idx}</Index>
};

(: Main body :)

let $indices := distinct-values( local:find-invalid-entrenchment-indices() )
let $entries := distinct-values( local:find-invalid-entrenchment-entries() )

return <Entrenchments>
			{
				<Indices>
				{
					for $idx in $indices
						return <Index>{$idx}</Index>
				}
				</Indices>
			}
			{
				<Entries>
				{
					for $entry in $entries
						return <Entry>{$entry}</Entry>
				}
				</Entries>
			}
			</Entrenchments>

