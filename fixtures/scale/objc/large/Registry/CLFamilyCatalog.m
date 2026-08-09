#import "CLFamilyCatalog.h"
#import "CaesarDescriptor.h"
#import "Rot13Descriptor.h"
#import "AtbashDescriptor.h"
#import "AffineDescriptor.h"
#import "VigenereDescriptor.h"
#import "AutokeyDescriptor.h"
#import "BeaufortDescriptor.h"
#import "GronsfeldDescriptor.h"
#import "TrithemiusDescriptor.h"
#import "KeywordDescriptor.h"
#import "SubstitutionDescriptor.h"
#import "RailfenceDescriptor.h"
#import "ScytaleDescriptor.h"
#import "ColumnarDescriptor.h"
#import "PolybiusDescriptor.h"
#import "BaconDescriptor.h"
#import "XorStaticDescriptor.h"
#import "XorRollingDescriptor.h"
#import "Rc4Descriptor.h"
#import "LcgStreamDescriptor.h"
#import "NibbleSwapDescriptor.h"
#import "RotByteDescriptor.h"
#import "BlockReverseDescriptor.h"
#import "FeistelDescriptor.h"
#import "TeaDescriptor.h"
#import "XteaDescriptor.h"
#import "Fnv1a32Descriptor.h"
#import "Djb2Descriptor.h"
#import "SdbmDescriptor.h"
#import "Adler32Descriptor.h"
#import "Crc32Descriptor.h"
#import "Sum16Descriptor.h"

@implementation CLFamilyCatalog

+ (NSArray *)all {
    NSMutableArray *descriptors = [NSMutableArray array];
        [descriptors addObject:[[CaesarDescriptor alloc] init]];
        [descriptors addObject:[[Rot13Descriptor alloc] init]];
        [descriptors addObject:[[AtbashDescriptor alloc] init]];
        [descriptors addObject:[[AffineDescriptor alloc] init]];
        [descriptors addObject:[[VigenereDescriptor alloc] init]];
        [descriptors addObject:[[AutokeyDescriptor alloc] init]];
        [descriptors addObject:[[BeaufortDescriptor alloc] init]];
        [descriptors addObject:[[GronsfeldDescriptor alloc] init]];
        [descriptors addObject:[[TrithemiusDescriptor alloc] init]];
        [descriptors addObject:[[KeywordDescriptor alloc] init]];
        [descriptors addObject:[[SubstitutionDescriptor alloc] init]];
        [descriptors addObject:[[RailfenceDescriptor alloc] init]];
        [descriptors addObject:[[ScytaleDescriptor alloc] init]];
        [descriptors addObject:[[ColumnarDescriptor alloc] init]];
        [descriptors addObject:[[PolybiusDescriptor alloc] init]];
        [descriptors addObject:[[BaconDescriptor alloc] init]];
        [descriptors addObject:[[XorStaticDescriptor alloc] init]];
        [descriptors addObject:[[XorRollingDescriptor alloc] init]];
        [descriptors addObject:[[Rc4Descriptor alloc] init]];
        [descriptors addObject:[[LcgStreamDescriptor alloc] init]];
        [descriptors addObject:[[NibbleSwapDescriptor alloc] init]];
        [descriptors addObject:[[RotByteDescriptor alloc] init]];
        [descriptors addObject:[[BlockReverseDescriptor alloc] init]];
        [descriptors addObject:[[FeistelDescriptor alloc] init]];
        [descriptors addObject:[[TeaDescriptor alloc] init]];
        [descriptors addObject:[[XteaDescriptor alloc] init]];
        [descriptors addObject:[[Fnv1a32Descriptor alloc] init]];
        [descriptors addObject:[[Djb2Descriptor alloc] init]];
        [descriptors addObject:[[SdbmDescriptor alloc] init]];
        [descriptors addObject:[[Adler32Descriptor alloc] init]];
        [descriptors addObject:[[Crc32Descriptor alloc] init]];
        [descriptors addObject:[[Sum16Descriptor alloc] init]];
    return descriptors;
}

@end
