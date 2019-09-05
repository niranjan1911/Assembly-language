#include<stdio.h>
#include<conio.h>
#include<dos.h>
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
  //Function to create a new directory
  printf("\nEnter the directory name:\n");
  scanf("%s",&dn);

  i.h.ah=0x39;//39 - used to create a directory
  i.x.dx=FP_OFF(dn);//Store the offset of the directory in dx
  s.ds=FP_SEG(dn);//Store the segment of the directory in ds
  intdosx(&i,&o,&s);
  if(o.x.cflag)
  {
	printf("\n Directory not created succesfully...");
  }
  else
  {
   printf("\nDirectory  created succesfully...");
  }
}
void createF()
{
	//Function to create a new file
	printf("\nEnter file name: ");
	scanf("%s",fn);

	i.h.ah = 0x3c;//3C - used to create a file
	i.x.dx = FP_OFF(fn);//Store the offset of the file in dx
	s.ds = FP_SEG(fn);//Store the segment of the file in ds
	intdosx(&i,&o,&s);
	if(o.x.cflag)
	{
		printf("\nCould not create file!");
	}
	else
	{
		printf("\nFile Created succesfully");
	}
}
void deleteF()
{
	//Function to delete a file
	printf("\nEnter file name: ");
	scanf("%s",fn);

	i.h.ah = 0x41;//41 - used to delete a file
	i.x.dx = FP_OFF(fn);//Store the offset of the file in dx
	s.ds = FP_SEG(fn);//Store the segment of the file in ds
	intdosx(&i,&o,&s);
	if(o.x.cflag)
	{
		printf("\nCould not delete file!");
	}
	else
	{
		printf("\nFile deleted succesfully");
	}
}
void copyF()
{
	//Function to Copy a file


	//1.Opening first file
	printf("\nEnter file name from which the contents to be copy:");
	scanf("%s",file1);

	i.h.ah = 0x3d;//3d - used to open a file
	i.h.al=00;//Opening file in read mode
	i.x.dx = FP_OFF(file1);//Store the offset of the file in dx
	s.ds = FP_SEG(file1);//Store the segment of the file in ds
	intdosx(&i,&o,&s);
	h1=o.x.ax;//store the handeler of previously opened or created file
	if(o.x.cflag)
	{
		printf("\nCould not open first file...");
	}
	else
	{
		printf("\nFirst File open succesfully...");
	}

	//2.Creating second file
	printf("\nCreate a file to copy contents\nEnter the file name:");
	scanf("%s",file2);

	i.h.ah = 0x3c;//3c - used to create a file
	i.x.dx = FP_OFF(file2);//Store the offset of the file in dx
	s.ds = FP_SEG(file2);//Store the segment of the file in ds
	intdosx(&i,&o,&s);

	if(o.x.cflag)
	{
		printf("\nCould not create file for copying purpose...");
	}
	else
	{
		printf("\nFile created succesfully for copy operation...");
	}

	//3.Opening second file

	i.h.ah = 0x3d;//3d - used to open a file
	i.h.al=01;//Opening file in Write mode
	i.x.dx = FP_OFF(file2);//Store the offset of the file in dx
	s.ds = FP_SEG(file2);//Store the segment of the file in ds
	intdosx(&i,&o,&s);
	h2=o.x.ax;//store the handeler of previously opened or created file
	if(o.x.cflag)
	{
		printf("\nCould not open second file...");
	}
	else
	{
		printf("\nSecond File open succesfully...");
	}

	//4.Reading from first file

	i.h.ah = 0x3f;//3d - used to read a file
	i.x.bx = h1;//store the handler in bx
	i.x.cx = 0xff;//define size
	i.x.dx = FP_OFF(buffer);//Store the offset of the file in dx
	s.ds = FP_SEG(buffer);//Store the segment of the file in ds
	intdosx(&i,&o,&s);

	if(o.x.cflag)
	{
		printf("\nCould not read from first file...");
	}
	else
	{
		printf("\nFirst File read succesfull...");
	}

	//5.Writing into second file

	i.h.ah = 0x40;//40 - used to write a file
	i.x.bx = h2;//store the handler in bx
	i.x.cx = 0xff;//define size
	i.x.dx = FP_OFF(buffer);//Store the offset of the file in dx
	s.ds = FP_SEG(buffer);//Store the segment of the file in ds
	intdosx(&i,&o,&s);

	if(o.x.cflag)
	{
		printf("\nCould not Write into second file...");
	}
	else
	{
		printf("\nsecond File write succesfully...");
	}

	//6. Closing a files
	i.h.ah = 0x3e;//3e - used to Close a file

	i.x.bx=h1;
	i.x.dx = FP_OFF(file1);//Store the offset of the file in dx
	s.ds = FP_SEG(file1);//Store the segment of the file in ds
	intdosx(&i,&o,&s);

	i.x.bx=h2;
	i.x.dx = FP_OFF(file2);//Store the offset of the file in dx
	s.ds = FP_SEG(file2);//Store the segment of the file in ds
	intdosx(&i,&o,&s);

	if(o.x.cflag)
	{
		printf("\nCould close file...");
	}
	else
	{
		printf("\nFile close succesfully...");
	}


}
int main()
{
  int ch;
  clrscr();
  while(1)
  {
	printf("\n\n1.Create Directory\n2.create File\n3.Delete File\n4.Copy File\n5.Exit\n");
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
			  printf("\nYou have entered the wrong choice\n");
	}
  }
  return 0;
  getch();
}
