#pragma once

namespace NProfile
{
void LoadProfile();
void SaveProfile();
bool AddProfile( const wstring &szName );
// can change to non existing profile then one will be added
void ChangeProfile( const wstring &szProfile );
bool RemoveProfile( const wstring &szName );
void ResetToDefault();
void GetAllProfiles( vector<wstring> *pRes );
wstring GetCurrentProfileName();
string GetCurrentProfileDir();
}
