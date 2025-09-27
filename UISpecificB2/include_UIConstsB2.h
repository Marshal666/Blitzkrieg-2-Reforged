void PostLoad( bool bInEditor )
{
	SUIGameConsts::PostLoad( bInEditor );
	//
	for ( vector<SActionButton>::iterator it = actionButtons.begin(); it != actionButtons.end(); ++it )
		it->PostLoad( bInEditor );
	for ( vector<SM1ActionButton>::iterator it = m1ActionButtons.begin(); it != m1ActionButtons.end(); ++it )
		it->PostLoad( bInEditor );
	for ( vector<SMLTag>::iterator it = tags.begin(); it != tags.end(); ++it )
		it->PostLoad( bInEditor );
	for ( vector<SMPLocalizedGameType>::iterator it = mPLocalizedGameTypes.begin(); it != mPLocalizedGameTypes.end(); ++it )
		it->PostLoad( bInEditor );
}