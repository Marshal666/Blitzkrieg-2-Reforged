xquery version "1.0";

<WrongLinks>
{
let $objects := doc("MapInfo.xdb")/MapInfo/Objects/Item

for $obj at $pos in $objects
	where xs:integer($obj/Link/LinkWith) != -1 and empty( index-of($objects/Link/LinkID, $obj/Link/LinkWith) )
	return <Index>{$pos}</Index>
}
</WrongLinks>
