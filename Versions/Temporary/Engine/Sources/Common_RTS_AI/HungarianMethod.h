#pragma once
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  ���������� ����� ������� ������ � �����������. ������������ ��� ������ �����, ����� ������ ������ ���������� �������
//� �������� �����, ��� ��� �� ���� ������� ����� ��� ���������. ��� ������������� ���������� ������� ���������� �����
//����� ������� � ����� �������, �� ���� matrix[point][unit] = fabs( unit_pos - point_pos ).
//  ������������������ ��������: Init( matrix ), Solve() ����� GetResult( unit ) ���������� ����� ����� � ������� �����
//������� ���� ����.
class CHungarianMethod
{
	int nSize;
	CArray2D<float> matrix;
	vector<int> result;

	CArray2D<int> marks;
	vector<int> row, col, markRow, markCol;

	void Minimize();
	void MarkZeros();
	bool FindMatchingInRow( const int nRow );
	bool SwapMarks();
	bool IsSolved() const;
	void UpdateMatrix();
	void BuildResult();

public:
	CHungarianMethod() : nSize( 0 ) {}
	bool Init( const CArray2D<float> &matrix );
	void Solve();
	const int GetSize() const { return nSize; }
	const int GetResult( const int nIndex ) const { return result[nIndex]; }
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
