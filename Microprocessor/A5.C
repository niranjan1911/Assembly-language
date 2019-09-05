#include<dos.h>
#include<stdio.h>
#include<conio.h>
#include<stdlib.h>

char dn[20];
char fn[20];
char file1[20];
char file2[20];
char buffer[200];

int h1,h2;

union REGS i,o;
struct SREGS s;

void createD()
{
	printf("\nEnter Directory name to be created:");
	scanf("%s",&dn);

	i.h.ah=0x39;
	i.x.dx=FP_OFF(dn);
	s.ds=FP_SEG(dn);
	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nDirectory Not creted");
	else
		printf("\nDirectory Created");
}

void createF()
{
	printf("\nEnter name of file to be crteated:");
	scanf("%s",&dn);

	i.h.ah=0x3c;
	i.x.dx=FP_OFF(dn);
	s.ds=FP_SEG(dn);
	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nFile not created");
	else
		printf("\nFile created Successfully");
}
void deleteF()
{
	printf("\nEnter filename to be deleted:");
	scanf("%s",&dn);

	i.h.ah=0x41;
	i.x.dx=FP_OFF(dn);
	s.ds=FP_SEG(dn);
	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nCould not delete file");
	else
		printf("\nFile deleted successfully!");
}
void copyF()
{
	//1.Opening First File
	printf("\nEnter file name from which contents to be copied:");
	scanf("%s",&file1);

	i.h.ah=0x3d;
	i.h.al=00;	//Open file in Read Mode
	i.x.dx=FP_OFF(file1);
	s.ds=FP_SEG(file1);
	intdosx(&i,&o,&s);
	h1=o.x.ax;
	if(o.x.cflag)
		printf("\nCould not open first file");
	else
		printf("\nFirst file opened successfully!");

	//2.Creating Second File
	printf("\nEnter file name to which contents to be copied:");
	scanf("%s",&file2);

	i.h.ah=0x3c;
	i.x.dx=FP_OFF(file2);
	s.ds=FP_SEG(file2);
	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nCould not create second file");
	else
		printf("\nSecond file created Successfully!");

	//3.Opening Second file in write mode
	i.h.ah=0x3d;
	i.h.al=01;	//Opening File in Write Mode
	i.x.dx=FP_OFF(file2);
	s.ds=FP_SEG(file2);
	intdosx(&i,&o,&s);
	h2=o.x.ax;
	if(o.x.cflag)
		printf("\nCould not open Second file");
	else
		printf("\nSecond File Opened Successfully!");

	//4.Reading Data From First File
	i.h.ah=0x3f;
	i.x.bx=h1;
	i.x.cx=0xff;
	i.x.dx=FP_OFF(buffer);
	s.ds=FP_SEG(buffer);
	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nCould not read from first file");
	else
		printf("\nRead from first file successfull!");

	//5.Writing Data to Second File
	i.h.ah=0x40;
	i.x.bx=h2;
	i.x.cx=0xff;
	i.x.dx=FP_OFF(buffer);
	s.ds=FP_SEG(buffer);
	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nCould not write to second file");
	else
		printf("\nWriting to file Successfull!");

	//6.Closing File
	i.h.ah=0x3e;

	i.x.bx=h1;
	i.x.dx=FP_OFF(file1);
	s.ds=FP_SEG(file1);
	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nCould not close first file");
	else
		printf("\nFirst file closed Successfully!");

	i.x.bx=h2;
	i.x.dx=FP_OFF(file2);
	s.ds=FP_SEG(file2);
	intdosx(&i,&o,&s);
	if(o.x.cflag)
		printf("\nCould not close second file");
	else
		printf("\nSecond file closed successfully!");
}
int main()
{
	int ch;
	clrscr();
	while(1)
	{
		printf("\n1.Create Direcotory\n2.Create File\n3.Delete File\n4.Copy File\n5.Exit");
		printf("\nEnter Your Choice:");
		scanf("%d",&ch);


		switch(ch)
		{
			case 1:
				createD();
				break;
			case 2:
				createF();
				break;
			case 3:
				deleteF();
				break;
			case 4:
				copyF();
				break;
			case 5:
				return 0;
			default:
				return 0;
		}
	}
	return 0;
	getch();
}