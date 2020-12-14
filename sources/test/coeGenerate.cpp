#include<bits/stdc++.h>
#define fo(i,a,b) for(int i=a;i<=b;i++)
using namespace std;

char s[10];
string s1,s2,s3,s4;

int main()
{
	freopen("code.txt","r",stdin);
	
	while (scanf("%s",s+1)!=EOF)
	{
		s1+=s[1]; s1+=s[2]; s1+=",\n";
		s2+=s[3]; s2+=s[4]; s2+=",\n";
		s3+=s[5]; s3+=s[6]; s3+=",\n";
		s4+=s[7]; s4+=s[8]; s4+=",\n";
	}
	
	s1[s1.size()-2]=';';
	s2[s2.size()-2]=';';
	s3[s3.size()-2]=';';
	s4[s4.size()-2]=';';
	
	freopen("Instructions31_24.coe","w",stdout);
	puts("memory_initialization_radix=16;");
	puts("memory_initialization_vector=");
	cout << s1;
	fclose(stdout);
	
	freopen("Instructions23_16.coe","w",stdout);
	puts("memory_initialization_radix=16;");
	puts("memory_initialization_vector=");
	cout << s2;
	fclose(stdout);
	
	freopen("Instructions15_8.coe","w",stdout);
	puts("memory_initialization_radix=16;");
	puts("memory_initialization_vector=");
	cout << s3;
	fclose(stdout);
	
	freopen("Instructions7_0.coe","w",stdout);
	puts("memory_initialization_radix=16;");
	puts("memory_initialization_vector=");
	cout << s4;
	fclose(stdout);
}